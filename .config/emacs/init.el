;; Install elpaca
(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
			      :ref nil :depth 1
			      :files (:defaults "elpaca-test.el" (:exclude "extensions"))
			      :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
	(if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
		 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
						 ,@(when-let ((depth (plist-get order :depth)))
						     (list (format "--depth=%d" depth) "--no-single-branch"))
						 ,(plist-get order :repo) ,repo))))
		 ((zerop (call-process "git" nil buffer t "checkout"
				       (or (plist-get order :ref) "--"))))
		 (emacs (concat invocation-directory invocation-name))
		 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
				       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
		 ((require 'elpaca))
		 ((elpaca-generate-autoloads "elpaca" repo)))
	    (progn (message "%s" (buffer-string)) (kill-buffer buffer))
	  (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install use-package support and enable :ensure support
(elpaca elpaca-use-package
     (elpaca-use-package-mode))

(use-package kanagawa-themes
    :ensure t
    :config
    (load-theme 'kanagawa-dragon t))


;; Key Bindings
(use-package general
    :ensure (:wait t)
    :config
    (general-evil-setup t))

;; Vim Bindings
(use-package evil
    :ensure t
    :init
    :config
    (evil-mode 1))

(general-def 'insert
    "j" (general-key-dispatch 'self-insert-command
    :timeout 0.1
    "k" 'evil-normal-state))

(use-package markdown-mode
    :ensure t
    :mode ("README\\.md\\'" . gfm-mode)
    :commands (markdown-mode gfm-mode)
    :init (setq markdown-command "multimarkdown")
    )

(use-package math-preview
    :ensure t)

(use-package restart-emacs :ensure t)

(use-package org-auto-tangle
:ensure t
:load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
:defer t
:hook (org-mode . org-auto-tangle-mode))

;; Don't show splash screen
  (setq inhibit-startup-message t)

  (setq warning-minimum-level :emergency)

  (setq frame-resize-pixelwise t) ; Remove weird gaps at bottom and right edges

  (menu-bar-mode -1) ; Disable menu bar
  (tool-bar-mode -1) ; Disable tool bar
  (scroll-bar-mode -1) ; Disable scroll bar

  (column-number-mode) ; Display column number on mode bar

  (global-display-line-numbers-mode 1) ; Display line numbers
  (set-face-attribute 'default nil :family "monospace" :height 120)

(setq-default tab-width 4 indent-tabs-mode nil)
(setq org-src-tab-acts-natively t)
  (setq org-src-tab-preserve-indentation t)
