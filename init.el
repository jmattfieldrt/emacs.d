(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(global-hl-line-mode t)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(org-agenda-files
   (quote
    ("~/org/agenda/work.org" "~/org/agenda/home.org" "~/org/agenda/education.org")))
 '(win-switch-idle-time 3))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "color-234"))))
 '(message-header-cc ((t (:foreground "color-29"))))
 '(message-header-newsgroups ((t (:foreground "color-29" :slant italic :weight bold))))
 '(message-header-other ((t (:foreground "color-72"))))
 '(message-header-subject ((t (:foreground "color-29" :weight bold))))
 '(message-header-to ((t (:foreground "color-29" :weight bold))))
 '(org-document-info ((t (:foreground "color-239"))))
 '(org-document-title ((t (:foreground "color-239" :weight bold)))))

;;; Package management
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("gnu" .
      "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
    '("melpa" .
      "http://melpa.org/packages/"))
(package-initialize) 
(setq jpm-required-packages
      (list 'win-switch 'org 'launchctl 'magit))
(dolist (package jpm-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

;;; Backup and auto-save
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; Super key for OSX
(setq mac-option-modifier 'super)

;;; Turn other-window into a window switching mode
(require 'win-switch)
(global-set-key "\C-xo" 'win-switch-dispatch)

;;; Org Mode setup
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; Customize line numbering
(defun linum-format-func (line)
  (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
    (propertize (format (format "%%%dd " w) line) 'face 'linum)))
(setq linum-format 'linum-format-func)
(add-hook 'prog-mode-hook 'linum-mode)

