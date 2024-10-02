;; Don't show splash screen
(setq inhibit-startup-message t)

(setq warning-minimum-level :emergency)

(setq frame-resize-pixelwise t) ; Remove weird gaps at bottom and right edges

(menu-bar-mode -1)
(tool-bar-mode -1) ; Disable tool bar
(scroll-bar-mode -1) ; Disable scroll bar

(column-number-mode) ; Display column number on mode bar
(global-display-line-numbers-mode 1) ; Display line numbers

(set-frame-font "Hurmit Nerd Font 12" nil t)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(unless (package-installed-p 'use-package) (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package kanagawa-themes
    :ensure t
    :config
    (load-theme 'kanagawa-dragon t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(math-preview kanagawa-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Key Bindings
(use-package general
    :config
    (general-evil-setup t))

;; Vim Bindings
(use-package evil
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

(use-package math-preview)
