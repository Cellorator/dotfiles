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
(global-auto-revert-mode) ; Automatically update chaged buffers

;; Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq-default indent-tabs-mode nil) ;; Use spaces instead of tabs

(setq-default show-trailing-whitespace t) ;; Highligh trailing spaces

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

;; More convenient keybind setting
(use-package general
  :config (general-evil-setup t)
  :ensure t)

;; Emulate vim keybindings
(use-package evil
  :init
  (setq evil-want-keybinding nil) ; So evil-collection doesn't yell at me
  (setq evil-want-C-i-jump nil) ; Make TAB work normally (auto-indent)
  (setq evil-respect-visual-line-mode t)  ; Make j and k move between wrapped lines
  (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1)
  :ensure t)
(use-package evil-collection
  :config (evil-collection-init)
  :after evil
  :ensure t)
;; Nice org keybindings for evil
(use-package evil-org
  :hook org-mode
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  :after org
  :ensure t)


;; Undo and redo
(use-package undo-fu :ensure t)
(use-package undo-fu-session
  :ensure t
  :config (undo-fu-session-global-mode))

(use-package which-key
  :custom
  (which-key-add-column-padding 3)
  :config (which-key-mode))

;; Set leader key
(general-create-definer <leader>
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

;; Macros
(general-def
  "C-SPC" (general-simulate-key "C-c"))

;; Copy paste
(<leader>
  "y" '(clipboard-kill-ring-save :wk "Copy to clipboard")
  "p" '(clipboard-yank :wk "Paste from clipboard"))

;; Filesystem
(<leader>
  "f" '(:ignore t :wk "Find")
  "ff" '(find-file :wk "Find file")
  "fd" '(dired :wk "Find directory (dired)"))

;; Buffers
(<leader>
  "b" '(:ignore t :wk "Buffers")
  "bb" '(consult-buffer :wk "Switch to buffer")
  "bj" '(next-buffer :wk "Next buffer")
  "bk" '(previous-buffer :wk "Previous buffer")
  "br" '(revert-buffer :wk "Reload changes to buffer")
  "bw" '(kill-this-buffer :wk "Kill current buffer"))

;; Windows
(<leader> "j" '(next-multiframe-window :wk "Next window"))
(<leader> "k" '(next-multiframe-window :wk "Previous window"))

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
  (completion-styles '(orderless partial-completion basic))
  (orderless-matching-styles '(orderless-initialism
                               orderless-literal
                               orderless-regexp
                               orderless-flex))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Completion UI
(use-package vertico
  :init (vertico-mode)
  :ensure t)

(use-package consult
  :hook
  (minibuffer-setup . (lambda ()
                        (setq completion-in-region-function
                              #'consult-completion-in-region)))
  :ensure t)

;; Buffer completion
(use-package corfu
  :custom
  (corfu-auto t)
  (global-corfu-minibuffer nil)
  :init (global-corfu-mode)
  :ensure t)

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-keyword)
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-dict)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-tex)
  :ensure t)

(use-package yasnippet
  :config (yas-global-mode 1)
  :ensure t)

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  ;; Performance optimizations
  (gc-cons-threshold 1000000000)
  (read-process-output-max (* 1024 1024))
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless
  :hook
  ((lsp-completion-mode . my/lsp-mode-setup-completion)
   (csharp-mode . lsp))
  :ensure t)

(use-package treesit-auto
  :custom (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode)
  :ensure t)

(use-package csharp-mode
  ;; :config (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
  :ensure t)

(use-package embark
  :general
  (<leader>
    :states '(normal visual)
    "RET" 'embark-act)
  :ensure t)
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode)
  :ensure t)

;; Annotations in completion UI
(use-package marginalia
  :init (marginalia-mode)
  :ensure t)

;; Cool git front-end
(use-package magit
  :general
  (<leader>
    "g" '(magit :wk "Open Magit"))
  :ensure t)

;; Pdf-tools
(use-package pdf-tools
  :unless (eq system-type 'android)
  :config (pdf-loader-install)
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode -1))) ;; Remove line numbers
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
  ;; :config (load-theme 'kanagawa-dragon t)
  :ensure t)
(use-package doom-themes
  :config
  (doom-themes-org-config)
  (load-theme 'doom-old-hope t)
  :ensure t)

(use-package org
  :custom
  (org-startup-indented t)
  (org-startup-folded 'show2levels)
  (org-src-tab-acts-natively t) ; Make tab work in code blocks
  (org-src-preserve-indentation t) ; Stop annoying indentation when making a new line in code blocks
  (org-export-babel-evaluate 'inline-only)
  ;; Latex stuff
  (org-latex-packages-alist
   '(("" "esvect")
     ("" "tikz")
     ("" "tikz-cd")))
  (org-latex-create-formula-image-program 'dvisvgm) ; Makes tikz preview work
  (org-preview-latex-image-directory (concat user-emacs-directory "cache/org-latex/"))
  (org-agenda-files '("~/notes/inbox.org"))
  (org-capture-templates
   '(("t" "TODO")
     ("tt" "Unscheduled" entry
      (file+headline "~/notes/inbox.org" "Unscheduled")
      "* TODO %?")
     ("ts" "Scheduled" entry
      (file+headline "~/notes/inbox.org" "Scheduled")
      "* TODO %?\nSCHEDULED: %^T")
     ("n" "Note" entry
      (file+headline "~/notes/inbox.org" "Notes")
      "* %?")))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (org . t)
     (latex . t)))
  :hook
  (org-mode . (lambda () (display-line-numbers-mode -1))) ;; Remove line numbers
  :general
  (<leader>
    "o" '(:ignore t :wk "org-mode")
    "ole" '(org-latex-export-to-pdf :wk "Export to latex pdf"))
  (:keymaps 'override (general-nmap "RET" 'org-open-at-point)))

(use-package org
  :config
  ;; Resize Org headings
  (dolist (face '((org-level-1 . 1.5)
                  (org-level-2 . 1.35)
                  (org-level-3 . 1.25)
                  (org-level-4 . 1.2)
                  (org-level-5 . 1.2)
                  (org-level-6 . 1.2)
                  (org-level-7 . 1.2)
                  (org-level-8 . 1.2)))
    (set-face-attribute (car face) nil :font monospace-font :weight 'bold :height (cdr face)))
  ;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font monospace-font :weight
                      'bold :height 1.5)
  (plist-put org-format-latex-options :scale 1.3)) ; Make latex preview bigger

;; Replace text with cool symbols
(use-package org-modern
  :custom
  (org-modern-star 'replace)
  (org-modern-keyword nil)
  :hook org-mode
  :ensure t)

;; Make stuff dissapear and stuff
(use-package org-appear
  :custom
  (org-hide-emphasis-markers t) ; Hide bold and italic markup
  :hook org-mode
  :after org
  :ensure t)

;; Preview latex in editor
(use-package org-fragtog
  :custom (org-startup-with-latex-preview t)
  :hook org-mode
  :after org
  :ensure t)

;; Center text
(use-package olivetti
  :custom (olivetti-body-width 0.65)
  :hook org-mode
  :ensure t)

;; For tangling configuration file on save
(use-package org-auto-tangle
  :defer t
  :hook org-mode
  :after org
  :ensure t)

(use-package org-roam
  :after org
  :ensure t)

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

(setq org-roam-directory (file-truename "~/notes"))
(setq org-roam-db-location (file-truename "~/notes/org-roam.db"))
(org-roam-db-autosync-mode)
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))
(setq org-roam-node-display-template "${hierarchy:*}")
(setq org-roam-completion-everywhere t)

(setq org-roam-capture-templates
      '(("i" "main note" plain "%?"
         :target (file+head
                  "main/%<%Y%m%dT%H%M%S>--${slug}.org"
                  "#+title: ${title}\n#+date: [%<%Y-%m-%d %a %H:%M>]\n#+filetags:")
         :immediate-finish t
         :unnarrowed t)

        ("l" "literature note" plain "%?"
         :target (file+head
                  "references/${citar-citekey}.org"
                  "#+title: ${title}\n#+date: [%<%Y-%m-%d %a %H:%M>]\n")
         :immediate-finish t
         :unnarrowed t)

        ("a" "article" plain "%?"
         :target (file+head
                  "articles/${title}.org"
                  "#+title: ${title}\n#+date: [%<%Y-%m-%d %a %H:%M>]\n")
         :immediate-finish t
         :unnarrowed t)))

(require 'ucs-normalize)
(cl-defmethod org-roam-node-slug ((node org-roam-node))
  "Return the slug of NODE."
  (let ((title (org-roam-node-title node))
        (slug-trim-chars '(;; Combining Diacritical Marks https://www.unicode.org/charts/PDF/U0300.pdf
                           768 ; U+0300 COMBINING GRAVE ACCENT
                           769 ; U+0301 COMBINING ACUTE ACCENT
                           770 ; U+0302 COMBINING CIRCUMFLEX ACCENT
                           771 ; U+0303 COMBINING TILDE
                           772 ; U+0304 COMBINING MACRON
                           774 ; U+0306 COMBINING BREVE
                           775 ; U+0307 COMBINING DOT ABOVE
                           776 ; U+0308 COMBINING DIAERESIS
                           777 ; U+0309 COMBINING HOOK ABOVE
                           778 ; U+030A COMBINING RING ABOVE
                           780 ; U+030C COMBINING CARON
                           795 ; U+031B COMBINING HORN
                           803 ; U+0323 COMBINING DOT BELOW
                           804 ; U+0324 COMBINING DIAERESIS BELOW
                           805 ; U+0325 COMBINING RING BELOW
                           807 ; U+0327 COMBINING CEDILLA
                           813 ; U+032D COMBINING CIRCUMFLEX ACCENT BELOW
                           814 ; U+032E COMBINING BREVE BELOW
                           816 ; U+0330 COMBINING TILDE BELOW
                           817 ; U+0331 COMBINING MACRON BELOW
                           )))
    (cl-flet* ((nonspacing-mark-p (char)
                                  (memq char slug-trim-chars))
               (strip-nonspacing-marks (s)
                                       (ucs-normalize-NFC-string
                                        (apply #'string (seq-remove #'nonspacing-mark-p
                                                                    (ucs-normalize-NFD-string s)))))
               (cl-replace (title pair)
                           (replace-regexp-in-string (car pair) (cdr pair) title)))
      (let* ((pairs `(("[^[:alnum:][:digit:]]" . "-") ;; convert anything not alphanumeric
                      ("--*" . "-")                   ;; remove sequential underscores
                      ("^-" . "")                     ;; remove starting underscore
                      ("-$" . "")))                   ;; remove ending underscore
             (slug (-reduce-from #'cl-replace (strip-nonspacing-marks title) pairs)))
        (downcase slug)))))

(cl-defmethod org-roam-node-hierarchy ((node org-roam-node))
  (let ((level (org-roam-node-level node)))
    (concat
     (when (> level 0) (concat (org-roam-node-file-title node) " > "))
     (when (> level 1) (concat (string-join (org-roam-node-olp node) " > ") " > "))
     (org-roam-node-title node))))

(use-package denote
  :custom
  (denote-directory (file-truename "~/notes/"))
  (denote-rename-confirmations nil)
  (denote-known-keywords '(math linearalgebra calculus physics history))
  (denote-date-prompt-use-org-read-date t) ; Use cool org calendar for setting dates
  :config
  ;; Remove denote id in front matter, set here because doesn't work in :custom
  (setq denote-org-front-matter
        "#+title: %1$s
#+date: %2$s
#+filetags: %3$s\n")
  :ensure t)

;; Completion for annotations
(use-package citar
  :custom
  (citar-bibliography '("~/notes/references/bibliography.bib"))
  (citar-notes-paths '("~/notes/references"))
  (citar-library-paths '("~/notes/references/documents"))
  (org-cite-global-bibliography '("~/notes/references/bibliography.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :ensure t)
;; Integration with org-roam
(use-package citar-org-roam
  :custom
  (citar-org-roam-capture-template-key "l")
  (citar-org-roam-note-title-template "${title} (${author} ${date})")
  :config (citar-org-roam-mode)
  :after (citar org-roam)
  :ensure t)
(use-package citar-embark
  :no-require
  :config (citar-embark-mode)
  :after (citar embark)
  :ensure t)

(use-package org-noter
  :custom
  (org-noter-notes-search-path '("~/notes/references"))
  (org-noter-default-heading-title "$p$")
  (org-noter-disable-narrowing t) ; Disable only looking at one note when activating
  (org-noter-always-create-frame nil) ; Use current frame instead of making new one
  (org-noter-swap-window t) ; Move doc to rightside
  (org-noter-doc-split-fraction '(0.33 . 0.33)) ; Set doc view size
  (org-noter-use-indirect-buffer nil) ; Use actual buffers
  :general
  (general-nmap
    :keymaps '(org-noter-mode-map pdf-view-mode-map)
    "I" 'org-noter-insert-note
    "i" 'org-noter-insert-precise-note)
  :after org
  :ensure t)

(<leader>
  "nc" '(org-capture :wk "org-capture")
  "na" '(org-agenda :wk "org-agenda"))

(<leader>
  "n" '(:ignore t :wk "Notes")
  "nf" '(org-roam-node-find :wk "Find note")
  "ni" '(org-roam-node-insert :wk "Insert note")
  "nb" '(org-roam-buffer-toggle :wk "Open backlinks buffer"))

(<leader>
  "nm" '(:ignore t :wk "Modify note frontmatter (title, keywords, aliases, id)")
  "nmt" '(denote-rename-file-title :wk "Change title")
  "nmk" '(denote-rename-file-keywords :wk "Change keywords/filetags")
  "nma" '(org-roam-alias-add :wk "Add aliases")
  "nmi" '(org-id-get-create :wk "Create ID for file/headline")
  "nmm" '(denote-rename-file-using-front-matter :wk "Update filename from frontmatter")
  "nmn" '(denote-add-front-matter :wk "Regenerate fronmatter from filename"))

(<leader>
  "on" '(:ignore t :wk "org-noter")
  "ono" '(org-noter :wk "Open document")
  "onn" '(org-noter-sync-current-note :wk "Open page"))

;; Get this to work sometime
;; (defun org-noter-open()
;;   (interactive)
;;   (if (eq major-mode 'pdf-view-mode)
;;       (org-noter-sync-current-note)
;;     (org-noter)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-noter citar-embark citar-org-roam citar denote org-roam-ui org-roam org-auto-tangle olivetti org-fragtog org-appear org-modern doom-themes kanagawa-themes restart-emacs evil-commentary smartparens pdf-tools magit marginalia embark-consult embark treesit-auto lsp-mode yasnippet cape corfu consult vertico orderless which-key undo-fu-session undo-fu evil-org evil-collection evil general)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )