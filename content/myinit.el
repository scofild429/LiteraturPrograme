(global-set-key "\C-o" 'compile)
(global-set-key (kbd "C-c C-.") 'org-mark-ring-goto)
(global-set-key (kbd "C-M-,") 'menu-bar-mode)
(global-set-key (kbd "C-M-q") 'ivy-switch-buffer-kill)

(setq colon-double-space t)
;; tell the Emacs fill commands to insert two spaces after a colon:

;; Rebind 'C-x C-b' for 'buffer-menu'
(global-set-key "\C-x\C-b" 'buffer-menu)
;; which not only lists the buffers, but moves point into that window

;; Set cursor color
(set-cursor-color "white")

;; Set mouse color
(set-mouse-color "white")

;;(setq make-backup-files nil)

;;close tool bar 
(setq inhibit-startup-message t)
(tool-bar-mode -1)

;;close menu bar
(menu-bar-mode -1)

;;close toggle sroll bar
(toggle-scroll-bar -1)
;; parse
(show-paren-mode t)

;; user y and n instead of yes and no 
(fset 'yes-or-no-p 'y-or-n-p)

;; open line number at left side
;;  (global-linum-mode 1)

;; emacsclient -a "" -c
;; shortcut to open emacsclient settings in terminal

;; set the meta-key to be super key
;; (setq  x-meta-keysym 'super
;;        x-super-keysym 'meta)

;; open terminal 
(global-set-key "\C-\M-x" 'term)

;; open  eshell
(global-set-key "\C-x\ \C-x" 'shell)

;;open init.el file with f1
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") 'open-my-init-file)

;;open myinit.org file  with f2
(defun open-my-init-org-file()
  (interactive)
  (find-file "~/Dropbox/LiteraturPrograme/content/myinit.org"))
(global-set-key (kbd "<f2>") 'open-my-init-org-file)

;;open .bashrc file with f3
(defun open-my-bash-file()
  (interactive)
  (find-file "~/.bashrc"))
(global-set-key (kbd "<f3>") 'open-my-bash-file)

;;open .bashrc file with f4
(defun open-my-tagsnote-file()
  (interactive)
  (find-file "~/Dropbox/Note/Note.org.gpg"))
(global-set-key (kbd "<f4>") 'open-my-tagsnote-file)


;; trun off cl warning
(setq byte-compile-warnings '(cl-functions))

;; backup oder
(setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
(setq backup-by-copying t)

;;M-x toggle-truncate-line
;; off the word wrap 是否移动换行
(toggle-truncate-lines 1)

;; open window horizontally default
(setq split-height-threshold nil)
(setq split-width-threshold 0 )


;; automatically update file
(global-auto-revert-mode t)

;;M-n select-current-line
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))
(global-set-key (kbd "M-n") 'select-current-line)

;; read only file
(global-set-key (kbd "C-M-o") 'read-only-mode)

;;add load path
(add-to-list 'exec-path "/usr/bin/")
(add-to-list 'load-path "~/.emacs.d/loadpath/")

;; this is a interrupt for shell in babel  
(setq org-babel-sh-eoe-indicator nil)


;; toggle the hi lock mode to highlight with command
 (global-hi-lock-mode 1)

(use-package rainbow-delimiters)
(rainbow-delimiters-mode 1)

(use-package eglot
  :ensure t
 )
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-to-list 'eglot-server-programs '(web-mode "vls"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'web-mode-hook 'eglot-ensure)
(add-hook 'vue-mode-hook 'eglot-ensure)
(add-hook ' python-mode-hook 'eglot-ensure)

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(with-eval-after-load 'company
  (add-hook 'company-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-irony-c-headers
  :ensure t)

(use-package flycheck-irony
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package irony-eldoc
  :ensure t
  :config
  (add-hook 'irony-mode-hook #'irony-eldoc))

(use-package ob-ipython
  :ensure t
  )
(use-package ein
  :ensure t
  )

(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("/usr/bin/python3.8" . python-mode)
  :config
  (setq indent-tabs-mode nil)
  (setq python-indent-offset 4)
  ;; (setq auto-complete-mode nil)
  (use-package py-autopep8
    :ensure t
    :hook ((python-mode . py-autopep8-enable-on-save))
    )
  (add-hook 'python-mode-hook (lambda () (auto-complete-mode -1)))
  )

(setq flycheck-flake8rc "~/.config/flake8")
(use-package company-jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook (lambda ()
                                (add-to-list (make-local-variable 'company-backends)
                                             'company-jedi))))

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-rpc-backend "jedi")
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  )

;; (use-package virtualenvwrapper
;;   :ensure t
;;   :config
;;   (venv-initialize-interactive-shells)
;;   (venv-initialize-eshell))

;; (use-package pyvenv
;; :ensure t
;; :config
;; (pyvenv-mode t)



(defvar myPackages
  '(better-defaults
    elpy
    flycheck ;; add the flycheck package
    material-theme
    ein ;; add the ein package (Emacs ipython notebook)
    py-autopep8))

;; (setq python-shell-interpreter "ipython")
;; (setq python-shell-interpreter-args "-i --simple-prompt")

;; (use-package lsp-pyright
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-pyright)
;;                          (lsp))))  ; or lsp-deferred

;; (use-package python-mode
;; :ensure t
;; :hook (python-mode . lsp-deferred))

(use-package jupyter
    :ensure )

;; (add-to-list 'load-path "/snap/bin/jupyter")
;; (require 'jupyter)

    ;; (let ((client (jupyter-kernel-client)))
    ;;   (jupyter-comm-initialize client "kernel1234.json")
    ;;   (jupyter-start-channels client))

    ;; (use-package simple-httpd)
    ;;   (require 'simple-httpd)
    ;;   (setq httpd-root "/var/www")
    ;;   (httpd-start)

    ;; (use-package edit-server)
    ;;   (require 'edit-server)
    ;;   (edit-server-start)
    ;;   (load-file "~/.emacs.d/packages/jupyterlab_emacs/edit_server_jupyterlab.el")

(use-package haskell-mode
:ensure t
:config
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
)

;;; babel_haskell.el --- babel for haskell in src    -*- lexical-binding: t; -*-

;; Copyright (C) 2020  sx

;; Author: sx <sx@sx>
;; Keywords: tools, abbrev


(defun send-to-haskell/file-with-buffer (file-name buffer)
  "Load FILE-NAME in a REPL session and associate it with BUFFER."
  (haskell-interactive-mode-reset-error (haskell-session))
  (haskell-process-file-loadish
   (format "load \"%s\"" (replace-regexp-in-string
                          "\""
                          "\\\\\""
                          file-name))
   nil
   buffer))

(defun send-to-haskell/org-src-block (&optional arg)
  "Tangle the current Org mode source block and load it in a REPL session.
With one universal prefix argument, only tangle the block at point."
  (interactive "P")
  (let* ((src-block
          (cond ((string= major-mode "org-mode")
                 ;; In an Org mode buffer, is the cursor in a source block?
                 (let ((info (org-babel-get-src-block-info t)))
                   (if info
                       (list info nil (current-buffer))
                     nil)))
                (org-src-mode
                 ;; In a transient source code buffer.
                 (list org-src--babel-info (current-buffer)
                       (org-src--source-buffer)))
                (t
                 ;; Not in an Org mode source block or transient code buffer.
                 nil)))
         (is-haskell-src
          (and src-block (string= "haskell" (nth 0 (nth 0 src-block))))))
    (unless is-haskell-src
      (user-error "Not in a Haskell source code block"))
    (when is-haskell-src
      (let* ((info (nth 0 src-block))
             (code-buffer (nth 1 src-block))
             (org-buffer (nth 2 src-block))
             (lang (nth 0 info))
             (contents (nth 1 info))
             (params (nth 2 info))
             (tangle-to (cdr (assq :tangle params)))
             (posn (nth 5 info)))
        ;; Tangle the relevant code block(s) and get the tangled file name.
        (let ((out-file
               (cond ((string= tangle-to "no")
                      ;; Tangle this *single block* to a temporary file
                      (let* ((tmp-prefix "haskell-load-")
                             (tmp-suffix ".hs")
                             (tmp-file (concat
                                        (org-babel-temp-file tmp-prefix)
                                        tmp-suffix)))
                        (with-current-buffer org-buffer
                          (goto-char posn)
                          (let ((tangled-files
                                 (org-babel-tangle '(4) tmp-file)))
                            (message "Tangled: %s" tangled-files)
                            (nth 0 tangled-files)))))
                     (t
                      ;; Tangle all relevant blocks to a specified file
                      (with-current-buffer org-buffer
                        (goto-char posn)
                        ;; If `arg' is '(4), only tangle this single block.
                        (let* ((arg (if (equal arg '(4)) '(4) '(16)))
                               (tangled-files
                                (org-babel-tangle arg "haskell")))
                          (message "Tangled: %s" tangled-files)
                          (nth 0 tangled-files)))))))
          ;; Now visit this tangled file and load it in ghci.
          (if code-buffer
              ;; There is an existing code buffer, use a temporary buffer to
              ;; visit the tangled file.
              (with-temp-buffer
                (insert-file-contents out-file t)
                (send-to-haskell/file-with-buffer out-file code-buffer))
            ;; No existing code buffer, visit the file normally.
            ;; Set `NOWARN' to `t' to avoid prompting the user to reread the
            ;; file if the contents (on disk) have changed.
            (let ((tangled-buffer (find-file-noselect out-file t)))
              (with-current-buffer tangled-buffer
                ;; Ensure the buffer name starts and ends with an asterisk.
                (let ((buf-name (buffer-name)))
                  (unless (and (string-prefix-p "*" buf-name)
                               (string-suffix-p "*" buf-name))
                    (rename-buffer (concat "*" buf-name "*"))))
                (send-to-haskell/file-with-buffer out-file tangled-buffer))))
          nil)))))

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(setq x-select-enable-primary t)
(setq select-enable-primary t)

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; use xsel to copy/paste in emacs-nox
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    (defun xsel-paste-function()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output )))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ))

(defun move-line (n)
      "Move the current line up or down by N lines."
      (interactive "p")
      (setq col (current-column))
      (beginning-of-line) (setq start (point))
      (end-of-line) (forward-char) (setq end (point))
      (let ((line-text (delete-and-extract-region start end)))
        (forward-line n)
        (insert line-text)
        ;; restore point to original column in moved line
        (forward-line -1)
        (forward-char col)))

    (defun move-line-up (n)
      "Move the current line up by N lines."
      (interactive "p")
      (move-line (if (null n) -1 (- n))))

    (defun move-line-down (n)
      "Move the current line down by N lines."
      (interactive "p")
      (move-line (if (null n) 1 n)))


    (defun move-region (start end n)
      "Move the current region up or down by N lines."
      (interactive "r\np")
      (let ((line-text (delete-and-extract-region start end)))
        (forward-line n)
        (let ((start (point)))
          (insert line-text)
          (setq deactivate-mark nil)
          (set-mark start))))

    (defun move-region-up (start end n)
      "Move the current line up by N lines."
      (interactive "r\np")
      (move-region start end (if (null n) -1 (- n))))

    (defun move-region-down (start end n)
      "Move the current line down by N lines."
      (interactive "r\np")
      (move-region start end (if (null n) 1 n)))


  (defun move-line-region-up (&optional start end n)
    (interactive "r\np")
    (if (use-region-p) (move-region-up start end n) (move-line-up n)))

  (defun move-line-region-down (&optional start end n)
    (interactive "r\np")
    (if (use-region-p) (move-region-down start end n) (move-line-down n)))

;; don't work in SRC block

  (global-set-key (kbd "M-<up>") 'move-line-region-up)
  (global-set-key (kbd "M-<down>") 'move-line-region-down)

(use-package doom-themes
:ensure t 
:init 
(load-theme 'doom-palenight t))


;; (use-package heaven-and-hell
;;   :ensure t
;;   :init
;;   (setq heaven-and-hell-theme-type 'dark)
;;   (setq heaven-and-hell-themes
;;         '((light . doom-acario-light)
;;           (dark . doom-palenight)))
;;   :hook (after-init . heaven-and-hell-init-hook)
;;   :bind (("C-c <f6>" . heaven-and-hell-load-default-theme)
;;          ("<f6>" . heaven-and-hell-toggle-theme)))

;;  copy region or whole line
(global-set-key "\M-w"
  (lambda ()
    (interactive)
    (if mark-active
        (kill-ring-save (region-beginning)
        (region-end))
      (progn
       (kill-ring-save (line-beginning-position)
       (line-end-position))
       (message "copied line")))))


  ;; kill region or whole line
  (global-set-key "\C-w"
  (lambda ()
    (interactive)
    (if mark-active
        (kill-region (region-beginning)
     (region-end))
      (progn
       (kill-region (line-beginning-position)
    (line-end-position))
       (message "killed line")))))

(setq is-alpha nil)
(defun transform-window (a ab)
  (set-frame-parameter (selected-frame) 'alpha (list a ab))
  (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
  )
(global-set-key [(f8)] (lambda()
                         (interactive)
                         (if is-alpha
                             (transform-window 100 100)
                           (transform-window 75 50))
                         (setq is-alpha (not is-alpha))))

;;switch dictionaries between German and English with F9 key
  (defun fd-switch-dictionary()
    (interactive)
    (let* ((dic ispell-current-dictionary)
           (change (if (string= dic "deutsch8") "english" "deutsch8")))
      (ispell-change-dictionary change)
      (message "Dictionary switched from %s to %s" dic change)
      ))
  (global-set-key (kbd "<f9>")   'fd-switch-dictionary)
(setq flyspell-mode t)

(defvar *echo-keys-last* nil "Last command processed by `echo-keys'.")

(defun echo-keys-mode ()
  (interactive)
  (if (member 'echo-keys-hook pre-command-hook)
      (progn
        (remove-hook 'pre-command-hook 'echo-keys-hook)
        (dolist (window (window-list))
          (when (eq (window-buffer window) (get-buffer "*echo-key*"))
            (delete-window window))))
    (progn
      (add-hook 'pre-command-hook 'echo-keys-hook)
      (delete-other-windows)
      (split-window nil (- (window-width) 8) t)
      (other-window 1)
      (switch-to-buffer (get-buffer-create "*echo-key*"))
      (set-window-dedicated-p (selected-window) t)
      (other-window 1))))

(defun echo-keys-hook ()
  (let ((deactivate-mark deactivate-mark))
    (when (this-command-keys)
      (with-current-buffer (get-buffer-create "*echo-key*")
        (goto-char (point-max))
        ;; self  self
        ;; self  other \n
        ;; other self  \n
        ;; other other \n
        (unless (and (eq 'self-insert-command *echo-keys-last*)
                     (eq 'self-insert-command this-command))
          (insert "\n"))
        (if (eql this-command 'self-insert-command)
            (let ((desc (key-description (this-command-keys))))
              (if (= 1 (length desc))
                  (insert desc)
                (insert " " desc " ")))
          (insert (key-description (this-command-keys)))
          )
        (setf *echo-keys-last* this-command)
        (dolist (window (window-list))
          (when (eq (window-buffer window) (current-buffer))
            ;; We need to use both to get the effect.
            (set-window-point window (point))
            (end-of-buffer)))))))

(provide 'echo-keys)

;; (use-package cnfonts
  ;; :ensure t
  ;; :config )

  ;;(require 'cnfonts)
   ;; 让 cnfonts 随着 Emacs 自动生效。
;;   (cnfonts-enable)
   ;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
  ;;(cnfonts-set-spacemacs-fallback-fonts)

(use-package evil
  :ensure t
  )

(setq helm-descbinds-window-style 'same-window)
(setq ranger-dont-show-binary t)
(setq ranger-max-preview-size 10)
(setq ranger-excluded-extensions '("mkv" "iso" "mp4"))
(setq ranger-width-preview 0.55)
(setq ranger-show-literal t)
(setq ranger-preview-file t)
(global-set-key (kbd "C-M-r") 'ranger)

(defun efs/ielm-send-line-or-region ()
  (interactive)
  (unless (use-region-p)
    (forward-line 0)
    (set-mark-command nil)
    (forward-line 1))
  (backward-char 1)
  (let ((text (buffer-substring-no-properties (region-beginning)
                                              (region-end))))
    (with-current-buffer "*ielm*"
      (insert text)
      (ielm-send-input))

    (deactivate-mark)))

(defun efs/show-ielm ()
  (interactive)
  (select-window (split-window-vertically -10))
  (ielm)
  (text-scale-set 1))

(define-key org-mode-map (kbd "C-c e") 'efs/ielm-send-line-or-region)
(define-key org-mode-map (kbd "C-c E") 'efs/show-ielm)

(use-package pdf-tools
  :ensure t
  :config)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package counsel
:ensure t
:bind
(("M-y" . counsel-yank-pop)
 :map ivy-minibuffer-map
 ("M-y" . ivy-next-line)))

(use-package ivy
:ensure t
:diminish (ivy-mode)
:bind (("C-x b" . ivy-switch-buffer))
:config
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "%d/%d ")
(setq ivy-display-style 'fancy))

(use-package swiper
:ensure t
:bind (("C-s" . swiper-isearch)
       ("C-c C-r" . ivy-resume)
       ("M-x" . counsel-M-x)
       ("C-x C-f" . counsel-find-file))
:config
(progn
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  ))

(use-package flex-autopair
  :ensure t
  :init (global-flex-autopair-mode t)
)

(use-package avy
:ensure t
:bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    )
  )
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

(use-package flycheck
    :ensure t
    :init
    (global-flycheck-mode t)
;;    (setq-default flycheck-flake8-maximum-line-length 99)
    )

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

(use-package yasnippet-snippets
  :ensure t
  :config)

(use-package auto-yasnippet
:ensure t)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package general
    :ensure t
    :config)
(general-define-key 
 "C-M-j" 'counsel-switch-buffer)

(use-package command-log-mode
 :ensure t
 )
(global-command-log-mode t)

(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework"
  )

(require 'eaf-mindmap)
(require 'eaf-browser)
(require 'eaf-pdf-viewer)
(require 'eaf-camera)
(require 'eaf-netease-cloud-music)
;;     (require 'eaf-file-manager)
(require 'eaf-jupyter)
;;     (require 'eaf-markdown-previewer)
;;     (require 'eaf-demo)
(require 'eaf-org-previewer)
;;     (require 'eaf-file-sender)
;;     (require 'eaf-file-browser)
;;     (require 'eaf-airshare)
(require 'eaf-music-player)
;;     (require 'eaf-rss-reader)
(require 'eaf-system-monitor)
(require 'eaf-vue-demo)
(require 'eaf-image-viewer)
(require 'eaf-terminal)
;;     (require 'eaf-video-player)
;;     (require 'eaf-mermaid)

;; (defun efs/exwm-update-class ()
;;   (exwm-workspace-rename-buffer exwm-class-name))

;; (use-package exwm
;;   :config
;;   ;; Set the default number of workspaces
;;   (setq exwm-workspace-number 5)

;;   ;; When window "class" updates, use it to set the buffer name
;;   ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

;;   ;; These keys should always pass through to Emacs
;;   (setq exwm-input-prefix-keys
;;     '(?\C-x
;;       ?\C-u
;;       ?\C-h
;;       ?\M-x
;;       ?\M-`
;;       ?\M-&
;;       ?\M-:
;;       ?\C-\M-j  ;; Buffer list
;;       ?\C-\ ))  ;; Ctrl+Space

;;   ;; Ctrl+Q will enable the next key to be sent directly
;;   (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;;   ;; Set up global key bindings.  These always work, no matter the input state!
;;   ;; Keep in mind that changing this list after EXWM initializes has no effect.
;;   (setq exwm-input-global-keys
;;         `(
;;           ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
;;           ([?\s-r] . exwm-reset)

;;           ;; Move between windows
;;           ([s-left] . windmove-left)
;;           ([s-right] . windmove-right)
;;           ([s-up] . windmove-up)
;;           ([s-down] . windmove-down)

;;           ;; Launch applications via shell command
;;           ([?\s-&] . (lambda (command)
;;                        (interactive (list (read-shell-command "$ ")))
;;                        (start-process-shell-command command nil command)))

;;           ;; Switch workspace
;;           ([?\s-w] . exwm-workspace-switch)

;;           ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
;;           ,@(mapcar (lambda (i)
;;                       `(,(kbd (format "s-%d" i)) .
;;                         (lambda ()
;;                           (interactive)
;;                           (exwm-workspace-switch-create ,i))))
;;                     (number-sequence 0 9))))

;;   (exwm-enable))

(use-package impatient-mode
:ensure t
:config )
(require 'impatient-mode)

;; projectile
(use-package projectile
  :ensure t
  :bind ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

;;(global-set-key (kbd "C-c C-f") 'fold-this-all)
(global-set-key (kbd "C-M-f") 'fold-this)
;;(global-set-key (kbd "C-c M-f") 'fold-this-unfold-all)

(use-package helm
  :ensure t
  :config )

  (helm-mode 1)
  (require 'helm-config)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;  (global-set-key (kbd "C-x C-f") 'helm-find-files)

(use-package magit
:ensure
:bind (("C-x g" . magit-status)))

(global-set-key "\C-\M-l" 'latex-math-preview-insert-mathematical-symbol)
;; bigger latex fragment: put this into the init.el, otherweise this will not be executed
(plist-put org-format-latex-options :scale 3.0)

(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 4))
(setq org-latex-create-formula-image-program 'dvipng)

(use-package tex
  :ensure auctex)

(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(setq org-latex-compiler "xelatex")

;;enable cdlatex
(use-package cdlatex
  :ensure t
  )

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))))

;;  (use-package json-mode)

(use-package grip-mode
:ensure t
:config)

(use-package markdown-mode
    :ensure t
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "multimarkdown"))

;; Enable Cache
  (setq url-automatic-caching t)

  ;; Example Key binding
  (global-set-key (kbd "C-M-w") 'youdao-dictionary-search-at-point+)

  ;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)
  ;; (push "*Youdao Dictionary*" popwin:special-display-config)

;;  Set file path for saving search history
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")

  ;; Enable Chinese word segmentation support (支持中文分词)
  ;; (setq youdao-dictionary-use-chinese-word-segmentation t)

(defun now ()
(interactive)
( insert (current-time-string)))

(use-package ob-html-chrome
:ensure t
:config)

  (require 'ob-html-chrome)
  (setq org-confirm-babel-evaluate
        (lambda (lang body)
          (not (string= lang "html-chrome"))))

  (setq org-babel-html-chrome-chrome-executable
        "/usr/bin/google-chrome")

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>". company-complete-selection))
        (:map lsp-mode-map
              ("<tab>" . company-indent-or-complete-common))
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (global-company-mode t))


(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  )

(use-package autoinsert
  :ensure t
  :config
  (setq auto-insert-query nil)
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode t))

(use-package org
  :hook (org-mode . efs/org-mode-setup))

(use-package visual-fill-column
  :ensure t
  :hook (org-mode . org-mode-center-fill))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(custom-set-variables
 ;;  (customize-set-variables
 '(org-directory "~/Dropbox")
 '(org-default-notes-file (concat org-directory "/Note.org"))
 '(org-export-html-postamble nil)
 '(org-hide-leading-stars t)
 '(org-startup-folded (quote overview))
 '(org-startup-indented t)
 '(org-confirm-babel-evaluate nil)
 '(org-src-fontify-natively t)
 )


;;hide the emphasis markup (e.g. /.../ for italics, *...* for bold)
(setq org-hide-emphasis-markers t)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(defun efs/org-mode-setup ()
    (org-indent-mode)
    (variable-pitch-mode 1)
    (auto-fill-mode 0)
    (visual-line-mode 1)
    (setq evil-auto-indent nil))

  (defun org-mode-center-fill ()
    (interactive)
    (setq visual-fill-column-width 100
          visual-fill-column-center-text t)
        (visual-fill-column-mode 1))

;; M-x: visual-fill-column-mode
;; this will automatic close if more space needed

(use-package htmlize :ensure t)
(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")
;;sure to enable software ditaa to work

(setq org-todo-keywords
      '((type  "Work(w)" "Study(s)" "forFun(f)" "|")
        (sequence  "TODO(t!)"  "|" "DONE(d!)")
        ))

(setq org-todo-keyword-faces
      '(
        ("Work" .       (:foreground "white" :weight bold))
        ("Study" .      (:foreground "yellow" :weight bold))
        ("forFun" .     (:foreground "red" :weight bold))
        ("DONE" .       (:foreground "green" :weight bold))
        ))

(require 'epa-file)
(setq epa-file-select-key 0)
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key nil)

(setq org-capture-templates
'(
  ;; ("a" "Appointment" entry (file+headline "~/Dropbox/Note/Appointment.org"     "Appointment")  "* %u %? " :prepend t)
  ;;("n" "TagsNote"    entry (file+headline "~/Dropbox/Note/Note.org.gpg"        "TagsNote")     "* %u %? " :prepend t)
  ("n" "TagsNote"    entry (file+headline "~/Dropbox/Note/Appointment.org"        "TagsNote")     "* %u %? " :prepend t)
;; ("m" "Math"          entry (file+headline "~/Dropbox/Sprache/Math/Math.org"           "Math")  "* %u %? " :prepend t)
;; ("p" "Physik"        entry (file+headline "~/Dropbox/Sprache/Physik/Physik.org"      "Physik")  "* %u %? " :prepend t)
;; ("r" "ROS"           entry (file+headline "~/Dropbox/Sprache/ROS/ROS.org"               "ROS")  "* %u %? " :prepend t)
;; ("i" "Inf"           entry (file+headline "~/Dropbox/Sprache/Inf/Inf.org"               "Inf")  "* %u %? " :prepend t)
))
(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))
(use-package noflet
  :ensure t )
(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))
    ;; (require 'ox-beamer)
    ;; for inserting inactive dates
    (define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

(global-set-key (kbd "C-c c") 'org-capture)

(global-set-key "\C-ca" 'org-agenda)
         (setq org-agenda-files (list 
                                 "~/Dropbox/Note/Appointment.org"
                                 ))
         (setq org-agenda-start-on-weekday nil)
         (setq org-agenda-custom-commands
               '(("c" "Simple agenda view"
                  ((agenda "")
                   (alltodo "")))))
 
(setq org-agenda-include-diary t)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Dropbox/OrgRoam/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?"
           :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-c n I" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c C-h" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-setup))

;;Journal
(setq org-roam-dailies-directory "journal/")

;; (use-package org-roam
;;   :ensure t
;;   :hook
;;   (after-init . org-roam-mode)
;;   :custom
;;   (org-roam-directory "~/Dropbox/subjects/")
;;   :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n g" . org-roam-graph))
;;               :map org-mode-map
;;               (("C-c n i" . org-roam-insert))
;;               (("C-c n I" . org-roam-insert-immediate))))

;; (add-hook 'after-init-hook 'org-roam-mode)

;; (use-package org-roam-server
;;   :ensure t
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 9090
;;         org-roam-server-export-inline-images t
;;         org-roam-server-authenticate nil
;;         org-roam-server-label-truncate t
;;         org-roam-server-label-truncate-length 60
;;         org-roam-server-label-wrap-length 20))
;;   (org-roam-server-mode)

;; (setq org-roam-completion-system 'helm)
;; (setq org-roam-buffer-width 0.2)

;; (defun my/org-roam--backlinks-list-with-content (file)
;;   (with-temp-buffer
;;     (if-let* ((backlinks (org-roam--get-backlinks file))
;;               (grouped-backlinks (--group-by (nth 0 it) backlinks)))
;;         (progn
;;           (insert (format "\n\n* %d Backlinks\n"
;;                           (length backlinks)))
;;           (dolist (group grouped-backlinks)
;;             (let ((file-from (car group))
;;                   (bls (cdr group)))
;;               (insert (format "** [[file:%s][%s]]\n"
;;                               file-from
;;                               (org-roam--get-title-or-slug file-from)))
;;               (dolist (backlink bls)
;;                 (pcase-let ((`(,file-from _ ,props) backlink))
;;                   (insert (s-trim (s-replace "\n" " " (plist-get props :content))))
;;                   (insert "\n\n")))))))
;;     (buffer-string)))

;; (defun my/org-export-preprocessor (backend)
;;   (let ((links (my/org-roam--backlinks-list-with-content (buffer-file-name))))
;;     (unless (string= links "")
;;       (save-excursion
;;         (goto-char (point-max))
;;         (insert (concat "\n* Backlinks\n") links)))))

;; (add-hook 'org-export-before-processing-hook 'my/org-export-preprocessor)

(use-package helm-org-rifle
:ensure t
:config)	    	    
  (require 'helm-org-rifle)

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :init
  (require 'ox-org)
  :ensure t
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :config
  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (setq org-mind-map-engine "twopi")  ; Radial Layout
  ;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (setq org-mind-map-engine "twopi")  ; Radial layouts
  ;; (setq org-mind-map-engine "circo")  ; Circular Layout
  )

(use-package org-noter
  :ensure t
  :config)

;; (defun my-beamer-bold (contents backend info)
;;   (when (eq backend 'beamer)
;;     (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

;; (add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

;; (defun my-beamer-structure (contents backend info)
;;   (when (eq backend 'beamer)
;;     (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\structure" contents)))

;; (add-to-list 'org-export-filter-strike-through-functions 'my-beamer-structure)

(setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (ipython . t)
     (emacs-lisp . t)
     (java . t)
     (shell . t)
     (sql . t)
     (C . t)
     (js . t)
     (dot . t)
     (plantuml . t)
     (ditaa . t)
     (haskell . t)
     (dot . t)
     (org . t)
     (latex . t )
     (typescript . t)
;;     (scala . t)
     (mongo . t)
     (julia-vterm . t )
     ))
  (with-eval-after-load 'org)

(use-package atomic-chrome
:ensure t
:config
(atomic-chrome-start-server))

(setq atomic-chrome-buffer-open-style 'frame)

(use-package multiple-cursors
  :ensure t
  :bind (
         ("M-0" . mc/edit-lines)
         ("M-1" . mc/mark-all-like-this)
         )
  )
;; (global-set-key (kbd "C-M-m") 'mc/edit-lines)
;; (global-set-key (kbd "C-M-a") 'mc/mark-all-like-this)

(use-package scala-mode
    :interpreter
    ("scala" . scala-mode))


;; (use-package scala-mode
;;   :mode "\\.s\\(cala\\|bt\\)$"
;;   :config
;;     (load-file "~/.emacs.d/packages/ob-scala.el"))

  ;; (use-package sbt-mode
  ;;   :commands sbt-start sbt-command
  ;;   :config
  ;;   ;; WORKAROUND: allows using SPACE when in the minibuffer
  ;;   (substitute-key-definition
  ;;    'minibuffer-complete-word
  ;;    'self-insert-command
  ;;    minibuffer-local-completion-map))


  ;; (use-package scala-mode
  ;;   :mode "\\.s\\(cala\\|bt\\)$"
  ;;   :config
  ;;   (load-file "~/.emacs.d/loadpath/ob-scala.el"))


  ;; (use-package ob-ammonite
  ;;   :ensure-system-package (amm . "sudo sh -c '(echo \"#!/usr/bin/env sh\" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/2.0.4/2.13-2.0.4) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm")
  ;;   :defer 1
  ;;   :config
  ;;   (use-package ammonite-term-repl)
  ;;   (setq ammonite-term-repl-auto-detect-predef-file nil)
  ;;   (setq ammonite-term-repl-program-args '("--no-remote-logging" "--no-default-predef" "--no-home-predef"))
  ;;   (defun my/substitute-sbt-deps-with-ammonite ()
  ;;     "Substitute sbt-style dependencies with ammonite ones."
  ;;     (interactive)
  ;;     (apply 'narrow-to-region (if (region-active-p) (my/cons-cell-to-list (region-bounds)) `(,(point-min) ,(point-max))))
  ;;     (goto-char (point-min))
  ;;     (let ((regex "\"\\(.+?\\)\"[ ]+%\\{1,2\\}[ ]+\"\\(.+?\\)\"[ ]+%\\{1,2\\}[ ]+\"\\(.+?\\)\"")
  ;;           (res))
  ;;       (while (re-search-forward regex nil t)
  ;;         (let* ((e (point))
  ;;                (b (search-backward "\"" nil nil 6))
  ;;                (s (buffer-substring-no-properties b e))
  ;;                (s-without-percent (apply 'concat (split-string s "%")))
  ;;                (s-without-quotes (remove-if (lambda (x) (eq x ?" ;"
  ;;                                                             ))
  ;;                                             s-without-percent))
  ;;                (s-as-list (split-string s-without-quotes)))
  ;;           (delete-region b e)
  ;;           (goto-char b)
  ;;           (insert (format "import $ivy.`%s::%s:%s`" (first s-as-list) (second s-as-list) (third s-as-list)))
  ;;           )
  ;;         )
  ;;       res)
  ;;     (widen)))





  ;; (use-package sbt-mode
  ;;   :commands sbt-start sbt-command
  ;;   :custom
  ;;   (sbt:default-command "testQuick")
  ;;   :config
  ;;   ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;;   ;; allows using SPACE when in the minibuffer
  ;;   (substitute-key-definition
  ;;    'minibuffer-complete-word
  ;;    'self-insert-command
  ;;    minibuffer-local-completion-map))

;; (use-package leetcode
;;   :ensure t
;;   :config
;;   (setq leetcode-save-solutions t)
;;   (setq leetcode-directory "~/.emacs.d/leetcode")"
;; )

(use-package company-web
  :ensure t)
(use-package web-mode
  :ensure t
  :mode ("\\.html\\'" "\\.vue\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-css-colorization t)
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "royalblue")
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "powderblue")
  (set-face-attribute 'web-mode-doctype-face nil :foreground "lightskyblue")
  ;; (setq web-mode-content-types-alist
  ;;       '(("vue" . "\\.vue\\'")))
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup))
                                   ;; ((member web-mode-content-type '("vue"))
                                   ;;  (my/web-vue-setup))
                                   )))
  )

(require 'company-web-html)
(defun my/web-html-setup()
  "Setup for web-mode html files."
  (message "web-mode use html related setup")
  ;; (flycheck-add-mode 'html-tidy 'web-mode)
  ;; (flycheck-select-checker 'html-tidy)
  (add-to-list (make-local-variable 'company-backends)
               '(company-web-html company-files company-css company-capf company-dabbrev))
  (add-hook 'before-save-hook #'sgml-pretty-print)

  )

;; (defun my/web-vue-setup()
;;   "Setup for js related."
;;   (message "web-mode use vue related setup")
;;   (setup-tide-mode)
;;   (prettier-js-mode)
;;   (flycheck-add-mode 'javascript-eslint 'web-mode)
;;   (flycheck-select-checker 'javascript-eslint)
;;   (my/use-eslint-from-node-modules)
;;   (add-to-list (make-local-variable 'company-backends)
;;                '(comany-tide company-web-html company-css company-files))
;;   )

(defun my/use-eslint-from-node-modules ()
  "Use local eslint from node_modules before global."
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; (use-package rjsx-mode
;;   :ensure t
;;   :mode ("\\.js\\'")
;;   :config
;;   (setq js2-basic-offset 2)
;;   (add-hook 'rjsx-mode-hook (lambda()
;;                               (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
;;                               (my/use-eslint-from-node-modules)
;;                               (flycheck-select-checker 'javascript-eslint)
;;                               ))
;;   (setq js2-basic-offset 2)
;;   )

;; (use-package react-snippets
;;   :ensure t)

(use-package css-mode
  :ensure t
  :mode "\\.css\\'"
  :config
  (add-hook 'css-mode-hook (lambda()
                             (add-to-list (make-local-variable 'company-backends)
                                          '(company-css company-files company-yasnippet company-capf))))
  (setq css-indent-offset 2)
  (setq flycheck-stylelintrc "/home/silin/.stylelintrc")
  )


(use-package scss-mode
  :ensure t
  :mode "\\scss\\'"
  )

(use-package emmet-mode
    :ensure t
;;    :hook (web-mode css-mode scss-mode sgml-mode rjsx-mode)
    :config
    (add-hook 'emmet-mode-hook (lambda()
                                 (setq emmet-indent-after-insert t)))
  
    )
  
  (use-package mode-local
    :ensure t
    :config
;;    (setq-mode-local rjsx-mode emmet-expand-jsx-className? t)
    (setq-mode-local web-mode emmet-expand-jsx-className? nil)  
    )

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . javascript-mode))
  :hook (js2-mode . lsp-deferred)
  :init
  (setq indent-tabs-mode nil)
  (setq js2-basic-offset 2)
  (setq js-indent-level 2)

  (setq-default js2-global-externs '("module" "require" "assert" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__d\
        irname" "console" "JSON"))
  (progn
    (add-hook 'js-mode-hook 'js2-minor-mode)
    )
  )

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode))
  (before-save . tide-format-before-save)
  :config
  (setq tide-completion-enable-autoimport-suggestions t)
  )


(defun setup-tide-mode ()
  "Setup tide mode for other mode."
  (interactive)
  (message "setup tide mode")
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;  (add-hook 'rjsx-mode-hook #'setup-tide-mode)

(use-package prettier-js
  :ensure t
  :hook ((js2-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode)
         (css-mode . prettier-js-mode)
         (web-mode . prettier-js-mode))
  :config
  (setq prettier-js-show-errors nil)
  (setq prettier-js-args '(
                           "--trailing-comma" "all"
                           "--bracket-spacing" "false"
                           ))
  )

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

    (use-package lsp-mode
  ;;    :straight t
      :commands (lsp lsp-deferred)
      :hook
      ((typescript-mode js2-mode web-mode) . lsp)
      (lsp-mdoe . efs/lsp-mode-setup)
      :init
      (setq lsp-keymap-prefix "C-c l")
      :config
      (lsp-enable-which-key-integration t)
      :bind (:map lsp-mode-map
                ("TAB" . completion-at-point))
      :custom (lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(setq lsp-ui-sideline-show-code-actions nil)
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-ui-sideline-enable nil)

(setenv "JAVA_HOME" "/usr/lib/jvm/java-11-openjdk-amd64")

(use-package lsp-treemacs
:after lsp)

;; (use-package dap-mode
;;   :ensure t
;;   :after (lsp-mode)
;;   :functions dap-hydra/nil
;;   :config
;;   (require 'dap-java)
;;   :bind (:map lsp-mode-map
;;          ("<f5>" . dap-debug)
;;          ("M-<f5>" . dap-hydra))
;;   :hook ((dap-mode . dap-ui-mode)
;;     (dap-session-created . (lambda (&_rest) (dap-hydra)))
;;     (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))

;; (use-package dap-java :ensure nil)

(use-package typescript-mode
:mode "\\.ts\\'"
:hook (typescript-mode . lsp-deferred)
:config
(setq typescript-indent-level 2))

(use-package ob-typescript
:ensure t
)

(use-package python-mode
  :ensure nil
  :hook (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "python"))

(package-install 'julia-mode)
(require 'julia-mode)
(package-install 'lsp-julia)
(use-package lsp-julia
  :config
  (setq lsp-julia-default-environment "~/.julia/environments/v1.7"))
(add-hook 'ess-julia-mode-hook #'lsp-mode)

(package-install 'julia-vterm)
(add-hook 'julia-mode-hook #'julia-vterm-mode)

(require 'ctable)
