;;; init.el --- Summary
;;; Commentary: 
;; Configuration file for Emacs

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "acb039d6f2c41b3bd852b448351b2979f44ef488026c95dd5228d2f6da57f574" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "b458d10c9ea0c8c465635b7b13e1bd23f04e6b696b1ca96cb2c4eca35a31641e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Include path to Org from GIT
;; (add-to-list 'load-path "~/Projects/git/org-mode/lisp/")
;; (add-to-list 'load-path "~/Projects/git/org-mode/contrib/lisp")

;; These following line are not necessary as pallet+cask manages packages installation
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/") t)

;; (package-initialize)

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(org-babel-load-file
 (expand-file-name "~/.emacs.d/emacs-init.org"
                   user-emacs-directory))

;;(put 'dired-find-alternate-file 'disabled nil)
