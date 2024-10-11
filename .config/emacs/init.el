;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Don't show splash screen
(setq inhibit-startup-message t)

(setq warning-minimum-level :emergency)

(setq frame-resize-pixelwise t) ; Remove weird gaps at bottom and right edges
(menu-bar-mode -1) ; Disable menu bar
(tool-bar-mode -1) ; Disable tool bar
(scroll-bar-mode -1) ; Disable scroll bar

(column-number-mode) ; Display column number on mode bar

(global-display-line-numbers-mode 1) ; Display line numbers
(set-face-attribute 'default nil :family "Hurmit Nerd Font" :height 120)

(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)

(when (string-equal system-type "android")
  ;; Enable bars
  (menu-bar-mode 1)
  (tool-bar-mode 1)
  ;; Set font
  (set-face-attribute 'default nil :family "monospace")
  ;; Open keyboard
  (setq touch-screen-display-keyboard t) 
  ;; Make keybinds work with on-screen keyboard
  (setq overriding-text-conversion-style nil))

(use-package general
  :ensure t
  :config (general-evil-setup t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil) ; Make TAB work properly in org-mode
  (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1))

;; Undo and redo
(use-package undo-fu :ensure t)
(use-package undo-fu-session
  :ensure t
  :config (undo-fu-session-global-mode))

;; Set leader key
(general-create-definer <leader>
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "C-SPC") ; Use Ctrl + Space as leader in insert mode

;; Filesystem
(<leader>
  "f" '(:ignore t :wk "Find")
  "ff" '(find-file :wk "Find file")
  "fd" '(dired :wk "Find directory (dired)"))

;; Buffers
(<leader>
  "b" '(:ignore t :wk "Buffers")
  "bb" '(switch-to-buffer :wk "Switch to buffer")
  "bj" '(next-buffer :wk "Next buffer")
  "bk" '(previous-buffer :wk "Previous buffer")
  "br" '(revert-buffer :wk "Reload changes to buffer")
  "bw" '(kill-this-buffer :wk "Kill current buffer"))

;; Reload
(defun reload-config()
  (interactive)
  (load-file user-init-file))
(<leader>
  "rr" '(reload-config :wk "Reload configuration")
  "re" '(restart-emacs :wk "Restart Emacs"))

;; Preview latex fragments
(setq org-startup-with-latex-preview t)

;; Bindings
(<leader>
  "o" '(:ignore t :wk "org-mode"))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org"))
  :general
  (<leader>
    "of" '(org-roam-node-find :wk "Find node")
    "oi" '(org-roam-node-insert-immediate :wk "Insert node"))
  :config
  (org-roam-db-autosync-toggle))

;; Insert a node without needing to edit it
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

;; Prettier
(use-package org-superstar
  :ensure t
  :hook
  (org-mode . (lambda () (org-superstar-mode 1))))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode))

(use-package org-fragtog
  :ensure t
  :after org
  :hook (org-mode . org-fragtog-mode))

;; For tangling configuration file on save
(use-package org-auto-tangle
  :ensure t
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(use-package ivy
  :ensure t
  :config (ivy-mode))

(use-package restart-emacs
  :ensure t)

(use-package kanagawa-themes
  :ensure t
  :config (load-theme 'kanagawa-dragon t))
