;; Custom Emacs Lisp setup for Org-mode HTML export
;; Used by build.sh to export .org files with improved styling

(setq org-html-doctype "html5")
(setq org-export-with-toc t)
(setq org-html-toc-depth 4)
(setq org-html-head-include-default-style t)
(setq org-export-babel-evaluate nil)

(setq org-html-head-extra
      (concat
       "<link rel=\"stylesheet\" href=\"style.css\"/>\n"
       "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"/>\n"
       "<script src=\"toc-sidebar.js\" defer></script>\n"))

(setq org-html-validation-link nil)

(setq org-html-postamble
      "<div class=\"kb-footer\"><a href=\"../index.html\" target=\"_parent\">&larr; Back to Index</a></div>")

(setq org-html-divs
      '((preamble  "div" "kb-preamble")
        (content   "div" "kb-content")
        (postamble "div" "kb-postamble")))

(setq org-html-container-element "div")
(setq org-html-htmlize-output-type nil)

(message "org-export-setup.el loaded successfully")
