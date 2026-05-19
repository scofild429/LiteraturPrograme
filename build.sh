#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# build.sh — Knowledge Base build script
# Usage: ./build.sh
#
# 1. Exports all .org files to HTML with custom styling
# 2. Generates categories.js (sidebar tree data)
# 3. Copies index.html from template
#
# NOTE: Requires emacs (for org export) and python3 (for JSON gen)
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_DIR="$SCRIPT_DIR/html"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
TMP_DIR="$SCRIPT_DIR/.build-tmp"

# --- Colors ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
info()  { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

# --- Check prerequisites ---
check_prereqs() {
    if ! command -v emacs &>/dev/null; then
        error "emacs not found in PATH. Please install Emacs."
        exit 1
    fi
    if ! emacs --batch --eval "(require 'ox-html)" 2>/dev/null; then
        error "Emacs org-mode HTML export not available."
        exit 1
    fi
    if ! command -v python3 &>/dev/null; then
        error "python3 not found in PATH. Please install Python 3."
        exit 1
    fi
    ok "Prerequisites: emacs, python3"
}

# --- Get HTML filename for an org file ---
get_html_name() {
    local org_file="$1"
    local html_name
    html_name=$(grep -m1 '^#+EXPORT_FILE_NAME:' "$org_file" 2>/dev/null | sed 's|.*/||' || true)
    if [ -z "$html_name" ]; then
        html_name="$(basename "$org_file" .org).html"
    fi
    echo "$html_name"
}

# --- Export org files to HTML ---
export_org_files() {
    info "Exporting org files to HTML..."

    mkdir -p "$HTML_DIR"
    rm -rf "$TMP_DIR"
    mkdir -p "$TMP_DIR"

    cp "$TEMPLATES_DIR/org-export.css" "$HTML_DIR/style.css"
    cp "$TEMPLATES_DIR/toc-sidebar.js" "$HTML_DIR/toc-sidebar.js"

    local exported=0 failed=0

    for org_file in "$SCRIPT_DIR"/*.org; do
        [ -f "$org_file" ] || continue
        [[ "$(basename "$org_file")" == "README.org" ]] && continue

        local org_name=$(basename "$org_file")
        local html_name=$(get_html_name "$org_file")
        local tmp_file="$TMP_DIR/$org_name"

        cp "$org_file" "$tmp_file"

        if grep -q '^#+EXPORT_FILE_NAME:' "$tmp_file"; then
            perl -i -pe "s|^#\\+EXPORT_FILE_NAME:.*|#+EXPORT_FILE_NAME: $HTML_DIR/$html_name|" "$tmp_file"
        else
            perl -i -pe "print \"#+EXPORT_FILE_NAME: $HTML_DIR/$html_name\\n\" if \$. == 1" "$tmp_file"
        fi

        perl -i -pe "s|^#\\+HTML_HEAD:.*orgcss.*||" "$tmp_file"

        info "  $org_name -> $html_name"

        if emacs --batch \
            -l "$TEMPLATES_DIR/org-export-setup.el" \
            --visit "$tmp_file" \
            --funcall org-html-export-to-html \
            > /dev/null 2>&1; then
            ((exported++)) || true
        else
            warn "  Failed: $org_name"
            ((failed++)) || true
        fi
    done

    rm -rf "$TMP_DIR"
    find "$SCRIPT_DIR" -maxdepth 1 -name "*.html" -not -name "index.html" -delete 2>/dev/null || true

    ok "Exported: $exported files (${failed} failed)"
}

# --- Generate categories.js and index.html using Python ---
generate_index() {
    info "Generating categories.js and index.html..."

    python3 << PYEOF
import json, os, time

BASE_DIR = "$SCRIPT_DIR"
HTML_DIR = "$HTML_DIR"
TEMPLATES_DIR = "$TEMPLATES_DIR"

# ---------- CATEGORY CONFIGURATION ----------
# Edit these lists to reorganize notes into categories.
# Note names should match the HTML filename (without .html)
CATEGORIES = [
    ("Computer Science",        "Linux  Blockchain CloudComputation CS CUDA k8s Mac ".split()),
    ("Programming Languages",   "C Emacs Golang Haskell JS Java Lisp Mysql Postgresql Python Rust TS ROS".split()),
    ("Artificial Intelligence", "DL ML NLP RL RAG AIEngineering LangChain transformer".split()),
    ("Website Development",     "Vue Web".split()),
    ("Disciplines",             "Physics Math Algorithm Parallelisum QuantumComputation DataScience DAMA DataStructure".split()),
    ("Notes",                   "受难记 笔记 OpenIdProject".split()),
]

EXTERNAL_LINKS = [
    ("Blog", "http://blog.silinzhao.com/"),
]
# ---------------------------------------------

def get_html_name(org_file):
    with open(org_file) as f:
        for line in f:
            if line.startswith('#+EXPORT_FILE_NAME:'):
                return line.split(':', 1)[1].strip().rsplit('/', 1)[-1]
    return os.path.splitext(os.path.basename(org_file))[0] + '.html'

def get_file_date(filepath):
    return time.strftime('%Y-%m-%d', time.localtime(os.stat(filepath).st_mtime))

org_map = {}
for fname in sorted(os.listdir(BASE_DIR)):
    if not fname.endswith('.org'):
        continue
    fpath = os.path.join(BASE_DIR, fname)
    html_name = get_html_name(fpath)
    note_name = os.path.splitext(html_name)[0]
    date = get_file_date(fpath)
    org_map[note_name] = (date, html_name)

cats_json = []
for cat_name, notes in CATEGORIES:
    notes_json = []
    for n in notes:
        if n in org_map:
            date, html_name = org_map[n]
            notes_json.append({"name": n, "url": f"html/{html_name}", "date": date})
        else:
            notes_json.append({"name": n, "url": f"html/{n}.html", "date": ""})
    cats_json.append({"name": cat_name, "notes": notes_json})

ext_json = [{"name": name, "url": url} for name, url in EXTERNAL_LINKS]

data = {"categories": cats_json, "externalLinks": ext_json}

with open(os.path.join(BASE_DIR, "categories.js"), "w") as f:
    f.write("const CATEGORIES_DATA = ")
    json.dump(data, f, ensure_ascii=False)

print("  categories.js generated")

# Copy index template
with open(os.path.join(TEMPLATES_DIR, "index.template.html")) as f:
    template = f.read()
with open(os.path.join(BASE_DIR, "index.html"), "w") as f:
    f.write(template)
print("  index.html generated")
PYEOF

    ok "Index files generated"
}

# --- Main ---
echo ""
echo -e "${CYAN}═══════════════════════════════════${NC}"
echo -e "${CYAN}  Knowledge Base Builder${NC}"
echo -e "${CYAN}═══════════════════════════════════${NC}"
echo ""

check_prereqs
echo ""
export_org_files
echo ""
generate_index
echo ""
ok "Build complete!"
echo ""
echo -e "  Open ${CYAN}index.html${NC} in your browser to view."
echo ""
