(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Update package archives
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package automatically
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; use-package setup
(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package atom-one-dark-theme
  :init
  (load-theme 'atom-one-dark t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  ;; Keymaps
  (define-key evil-normal-state-map (kbd "SPC fp") 'find-file)
  (define-key evil-normal-state-map (kbd "SPC or") 'reload-config)
  (define-key evil-normal-state-map (kbd ", s") 'save-buffer)
  (define-key evil-normal-state-map (kbd ", w") 'evil-delete-buffer)
  (define-key evil-normal-state-map ";" 'evil-ex))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package org
  :init
  (setq org-emphasis-alist
    '(("*" (bold :family "JetBrains Mono") org-bold)
      ("/" italic)
      ("_" underline)
      ("+" (:strike-through t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; COMMANDS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reload-config ()
  "Reload the Emacs config."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; KEYBINDINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make Escape quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; INTERFACE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Due to a bug in Emacs, we have to set the default font to a non-bold version
;; of Operator, and then manually set the bold font when needed.
(set-face-attribute 'default nil :family "JetBrains Mono" :height 150)
(setq-default line-spacing 5)

(tool-bar-mode -1) ;; Hide toolbar
(scroll-bar-mode -1) ;; Hide scrollbar
(menu-bar-mode -1) ;; Hide menu bar
(tooltip-mode -1)
(set-fringe-mode 10) ;; Window padding
(setq ring-bell-function 'ignore) ;; Disable audio bell
(setq inhibit-startup-message t) ;; Disable startup message

(setq default-directory "~/dev/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; DIRED ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
    insert-directory-program "/opt/homebrew/bin/gls"
    dired-listing-switches "-aBhl --group-directories-first"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; MISC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq custom-file (concat user-emacs-directory "/custom.el"))
