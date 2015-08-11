;; Add a few package archives
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Install my favorite packages automatically
(setq my/required-packages
      (list 'win-switch 'org 'launchctl 'magit 'use-package 'waher-theme 'flatland-theme))
(dolist (package my/required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))
(require 'use-package)

;; Backup
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))) ; 
(setq delete-old-versions -1)                                 ; keep all versions indefinitely

;; Auto-save
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Set Super key for OS X
(setq mac-option-modifier 'super)

;; Turn other-window into a window switching mode
(use-package win-switch
  :init
  (setq win-switch-idle-time 2)
  :bind ("C-x o" . win-switch-dispatch))

;; Set up Org Mode
(use-package org
  :bind (("C-c l" . org-store-link)
	 ("C-c c" . org-capture)
	 ("C-c a" . org-agenda)
	 ("C-c b" . org-iswitchb))
  :config
  (setq org-agenda-files
      '("~/org/agenda/work.org"
	"~/org/agenda/home.org"
	"~/org/agenda/education.org"))
  (set-face-attribute 'org-document-info nil :foreground "color-239")
  (set-face-attribute 'org-document-title nil :foreground "color-239" :weight 'bold))

;; Tweak mode line
(setq column-number-mode t)

;; Customize margin line numbering
(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
    (propertize (format (format "%%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)
(add-hook 'prog-mode-hook 'linum-mode)

;; Ido Mode
(use-package ido
  :config
  (ido-mode t))

;; Stuff I don't want in my repo
(load "~/.emacs.d/.secrets" 'noerror)

;; Theme
(setq custom-safe-themes '("fe243221e262fe5144e89bb5025e7848cd9fb857ff5b2d8447d115e58fede8f7" ; flatland
			   "394504bd559027641b544952d6e9e1c6dcb306b4d1b2c4ad6b98d3e6b5459683" ; waher
			   default))
(load-theme 'waher)

;; Highlight current line
(global-hl-line-mode)
(set-face-attribute 'hl-line nil :background "Color-234")

;;; Miscellaneous settings

;; Hide the menu bar
(menu-bar-mode -1)

;; Startup screen?  No thanks.
(setq inhibit-startup-screen t)

;; Keep scratch buffer empty
(setq initial-scratch-message nil)

;; Save customize settings in their own file
;; if I happen to use it
;; THIS MUST REMAIN AT THE BOTTOM OF THIS FILE
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

