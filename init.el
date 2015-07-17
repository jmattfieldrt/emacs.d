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

;;; Super key for OSX
(setq mac-option-modifier 'super)

;;; Org Mode setup
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; Disable menu bar
(menu-bar-mode -1)

;;; Disable welcome screen
(setq inhibit-startup-screen t)
