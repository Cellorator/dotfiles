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

(setq default-font "Hurmit Nerd Font")
(setq monospace-font default-font)
(setq variable-width-font "Metropolis")
(set-face-attribute 'default nil :family default-font :height 120)
(set-face-attribute 'fixed-pitch nil :family monospace-font :height 120)

(set-face-attribute 'variable-pitch nil :family variable-width-font :height 1.2)

(global-visual-line-mode) ; Enable line wrap

(savehist-mode) ; Save minibuffer history

;; Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

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
  (setq evil-want-keybinding nil) ; So evil-collection doesn't yell at me
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

;; Macros
(<leader>
  "SPC" (general-key "C-c C-c"))

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

;; A completion-style for space separated completion
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic)))

;; Buffer completion
(use-package corfu
  :custom (corfu-auto t)
  :init (global-corfu-mode)
  :ensure t)

;; Completion UI
(use-package vertico
  :init (vertico-mode)
  :ensure t)

;; Annotations in completion UI
(use-package marginalia
  :init (marginalia-mode)
  :ensure t)

(use-package consult
  :ensure t)

;; Cool git front-end
(use-package magit
  :general
  (<leader>
    "g" '(magit :wk "Open Magit"))
  :ensure t)

;; Treesitter
(use-package treesit-auto
  :custom (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
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
(setq org-src-tab-acts-natively t) ; Make tab work in code blocks
(setq org-src-preserve-indentation t) ; Don't indent when making a new line in code blocks
(setq org-hide-emphasis-markers t) ; Hide bold and italic markup

(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1))) ; Display line numbers

;; Bindings
(<leader>
  "o" '(:ignore t :wk "org-mode")
  "oci" '(org-id-get-create :wk "Create ID for file/headline"))

(general-def 'normal org-mode-map
  "RET" 'org-open-at-point)

;; Font theming
;; (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))

;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-block-begin-line nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-block-end-line nil :inherit 'fixed-pitch)

;; (set-face-attribute 'org-drawer nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-special-keyword nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-property-value nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-meta-line nil :inherit 'fixed-pitch)
(set-face-attribute 'org-document-info-keyword nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-meta-line nil :inherit 'fixed-pitch)

;; Resize Org headings
(dolist (face '((org-level-1 . 1.4)
                (org-level-2 . 1.3)
                (org-level-3 . 1.2)
                (org-level-4 . 1.1)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font monospace-font :weight 'bold :height (cdr face)))

;; Make the document title a bit bigger
(set-face-attribute 'org-document-title nil :font monospace-font :weight
'bold :height 1.8)

;; Fix indentation to fixed-pitch
;; (require 'org-indent)
;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))

;; (add-hook 'org-mode-hook 'variable-pitch-mode) ; Use variable-width font in org-mode

(plist-put org-format-latex-options :scale 1.5) ; Make latex preview bigger

(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/notes"))
  (org-roam-db-location (file-truename "~/notes/org-roam.db"))
  (org-roam-capture-templates
   '(("m" "main" plain "%?"
      :if-new (file+head "main/${slug}.org"
                         "#+title: ${title}\n")
      :immediate-finish t
      :unnarrowed t)
     ("r" "reference" plain "%?"
      :if-new
      (file+head "reference/${title}.org" "#+title: ${title}\n")
      :immediate-finish t
      :unnarrowed t)
     ("d" "document" plain "%?"
      :if-new
      (file+head "document/${title}.org" "#+title: ${title}\n#+filetags: :document:\n")
      :immediate-finish t
      :unnarrowed t)))
  :general (<leader>
	     "of" '(org-roam-node-find :wk "Find node")
	     "oi" '(org-roam-node-insert-immediate :wk "Insert node")
	     "oc" '(org-roam-capture :wk "Capture node")
	     "ot" '(org-roam-tag-add :wk "Add tags")
	     "oa" '(org-roam-alias-add :wk "Add aliases")
	     "ob" '(org-roam-buffer-toggle :wk "Open org-roam buffer"))
  :config
  (org-roam-db-autosync-mode)
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
		 (display-buffer-in-direction)
		 (direction . right)
		 (window-width . 0.33)
		 (window-height . fit-window-to-buffer)))
  :after org
  :ensure t)

;; Insert a node without needing to edit it
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

;; Set up org-roam-ui
(use-package org-roam-ui
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t)
  :after org-roam
  :ensure t)
(use-package websocket
    :after org-roam
    :ensure t)

;; Nice org keybindings for evil
(use-package evil-org
  :hook org-mode
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  :after org
  :ensure t)

;; Replace text with cool symbols
(use-package org-modern
  :custom
  (org-modern-star 'replace)
  (org-modern-keyword nil)
  :hook org-mode
  :ensure t)

;; Make stuff dissapear and stuff
(use-package org-appear
  :hook org-mode
  :after org
  :ensure t)

;; Preview latex in editor
(use-package org-fragtog
  :custom (org-startup-with-latex-preview t)
  :hook org-mode
  :after org
  :ensure t)

(use-package olivetti
  :custom (olivetti-body-width 0.5)
  :hook org-mode
  :ensure t)

;; For tangling configuration file on save
(use-package org-auto-tangle
  :defer t
  :hook org-mode
  :after org
  :ensure t)
