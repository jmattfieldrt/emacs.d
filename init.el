;; Add a few package archives
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Install packages
(defvar jmattfield/required-packages
  '(win-switch
    org
    launchctl
    magit
    use-package
    zen-and-art-theme))

(dolist (package jmattfield/required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))
(require 'use-package)

;; Startup options
(menu-bar-mode -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      initial-scratch-message nil
      sentence-end-double-space nil)
(setq-default fill-column 80)
(when window-system
  (set-frame-size (selected-frame) 230 70)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  
  ;; Change font size when monitor dpi crosses visibility threshold.
  ;; Unfortunately, this doesn't work as-is because x-display-pixel-width is the
  ;; monitors' combined width. Need to use display-monitor-attributes-list to
  ;; get resolution of monitor that dominates the Emacs frame.
  (if (> (x-display-pixel-width) 2000)
      (set-face-attribute 'default nil :height 100)
    (set-face-attribute 'default nil :height 120)))

;; Backup
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))) ; keep backups in one place
(setq delete-old-versions -1)                                 ; keep all versions indefinitely

;; Auto-save
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; A few tty keys not playing nice in Org Mode
(when (not window-system)
  (define-key input-decode-map "\e[1;10A" [S-M-up])
  (define-key input-decode-map "\e[1;10B" [S-M-down])
  (define-key input-decode-map "\e[1;10C" [S-M-right])
  (define-key input-decode-map "\e[1;10D" [S-M-left]))

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
  (setq org-agenda-files '("~/org/agenda/work.org" "~/org/agenda/home.org" "~/org/agenda/education.org")
	org-log-into-drawer t
	org-latex-packages-alist '(("" "tabu" nil)
				   ("" "hyperref" nil))))
;  (set-face-attribute 'org-document-info nil :foreground "#345678")
;  (set-face-attribute 'org-document-title nil :foreground "#345678" :weight 'bold))

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
(load-theme 'zen-and-art t)
(set-face-attribute 'font-lock-comment-face nil :foreground "#404a4a" :weight 'normal :slant 'italic) ; lighten comments to make them visible with this theme

;; Highlight current line
(global-hl-line-mode)
(set-face-attribute 'hl-line nil :background "#080808")

;; Server mode? Sure.
(server-start)

;; Save customize settings in their own file if I happen to use it
;; THIS MUST REMAIN AT THE BOTTOM OF THIS FILE
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

