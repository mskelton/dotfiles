(defvar bootstrap-version)
(let ((bootstrap-file
	(expand-file-name
	"straight/repos/straight.el/bootstrap.el"
	(or (bound-and-true-p straight-base-dir)
	    user-emacs-directory)))
	(bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	    "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	    'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)
(setq straight-use-package-by-default t)

(use-package evil
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

(use-package atom-one-dark-theme
  :init
  (load-theme 'atom-one-dark t))

(use-package org
  :init
  (setq org-emphasis-alist
    '(("*" (bold :family "JetBrains Mono") org-bold)
      ("/" italic)
      ("_" underline)
      ("+" (:strike-through t)))))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(when (string= system-type "darwin")
  (setq dired-use-ls-dired t
    insert-directory-program "/opt/homebrew/bin/gls"
    dired-listing-switches "-aBhl --group-directories-first"))

(defun reload-config ()
  "Reload the Emacs config."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; Make Escape quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

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

(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(setq custom-file (concat user-emacs-directory "/custom.el"))
