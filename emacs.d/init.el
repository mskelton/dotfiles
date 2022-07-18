;; Let's do this

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; PACKAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Update package archives
(unless package-archive-contents
  (package-refresh-contents))

;; Install all packages
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; My packages
(require 'use-package)
(use-package atom-one-dark-theme)
(use-package evil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; KEYBINDINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'evil)
(evil-mode 1)

;; Reload Emacs config
(define-key evil-normal-state-map (kbd ", r") (lambda ()
  (interactive)
  (load-file "~/.emacs.d/init.el")))

(define-key evil-normal-state-map (kbd "SPC p") 'find-file)
(define-key evil-normal-state-map (kbd "SPC s") 'save-buffer)
(define-key evil-normal-state-map (kbd "SPC w") 'evil-delete-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; INTERFACE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-theme 'atom-one-dark t)

;; Due to a bug in Emacs, we have to set the default font to a non-bold version
;; of Operator, and then manually set the bold font when needed.
(set-face-attribute 'default nil :family "Operator Mono SSm Reg" :height 150)
(setq-default line-spacing 5)

;; Org mode emphasis markers
;; (setq org-hide-emphasis-markers t)
(setq org-emphasis-alist
  '(("*" (bold :family "Operator Mono Ssm Lig") org-bold)
    ("/" italic)
    ("_" underline)
    ("+" (:strike-through t))))

;; Disable startup message
;; (setq inhibit-startup-message t)

;; Hide unnecessary UI elements
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; MISC ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

