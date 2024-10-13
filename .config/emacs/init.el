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

(setq inhibit-startup-message t) ; Don't show splash screen

(setq warning-minimum-level :emergency)

(setq frame-resize-pixelwise t) ; Remove weird gaps at bottom and right edges

(menu-bar-mode -1) ; Disable menu bar
(tool-bar-mode -1) ; Disable tool bar
(scroll-bar-mode -1) ; Disable scroll bar

(column-number-mode) ; Display column number on mode bar
(global-display-line-numbers-mode 1) ; Display line numbers

(set-face-attribute 'default nil :family "Hurmit Nerd Font" :height 120)

(setq org-src-tab-acts-natively t) ; Make tab work in code blocks properly
(setq org-src-preserve-indentation t) ; Don't indent when making a new line in code blocks

(global-visual-line-mode) ; Enable line wrap

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
  :config (general-evil-setup t)
  :ensure t)

(use-package evil
  :init
  (setq evil-want-C-i-jump nil) ; Make TAB work normally (auto-indent)
  (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1)
  :ensure t)
(use-package evil-collection
  :config (evil-collection-init)
  :after evil
  :ensure t)

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

(use-package corfu
  :custom (corfu-auto t)
  :init (global-corfu-mode)
  :ensure t)

(use-package ivy
  :ensure t
  :config (ivy-mode))

(use-package treesit-auto
  :custom (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  :ensure t)

(use-package magit
  :general
  (<leader>
    "g" '(magit :wk "Open Magit"))
  :ensure t)

(use-package smartparens
  :config
  (smartparens-global-mode)
  (require 'smartparens-config)
  :ensure t)

(use-package evil-commentary
  :config (evil-commentary-mode)
  :ensure t)

(use-package restart-emacs :ensure t)

(use-package kanagawa-themes
  :config (load-theme 'kanagawa-dragon t)
  :ensure t)

(require 'org)

(setq org-startup-indented t)

(setq org-startup-with-latex-preview t) ; Enable latex previews
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5)) ; Make latex preview bigger

;; Bindings
(<leader>
  "o" '(:ignore t :wk "org-mode"))

(general-def 'normal org-mode-map
  "RET" 'org-open-at-point)

;; Prettier
(use-package org-modern
  :custom
  (org-modern-star 'replace)
  :hook org-mode
  :ensure t)

(use-package org-appear
  :custom
  (org-hide-emphasis-markers t) ; Hide bold and italic markup
  (org-appear-trigger 'manual)
  :hook (org-mode . (lambda ()
		      (org-appear-mode)
		      (add-hook 'evil-insert-state-entry-hook
				#'org-appear-manual-start nil t)
		      (add-hook 'evil-insert-state-exit-hook
				#'org-appear-manual-stop nil t)))
  :after org
  :ensure t)


(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode)
  :ensure t)

;; For tangling configuration file on save
(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :ensure t)

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
