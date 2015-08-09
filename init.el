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
(setq win-switch-idle-time 2)
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

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
