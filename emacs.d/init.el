;;; init.el --- Summary
;;; Commentary:
;; Configuration file for Emacs

;;; Code:

;; List of packages repositories
(require 'cl)
(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
       '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

;; List of packages to be installed
(defvar required-packages
  '(ace-window
    adoc-mode
    aggressive-indent
    anzu
    auctex
    avy
    bookmark+
    company
    conkeror-minor-mode
    diminish
    dired+
    elfeed
    elfeed-org
    elpy
    ess
    evil
    evil-org
    exec-path-from-shell
    flatui-theme
    flycheck
    flycheck-pyflakes
    helm
    helm-projectile
    jedi
    julia-mode
    leuven-theme
    lua-mode
    magit
    markdown-mode
    naquadah-theme
    notmuch
    org
    org-bullets
    orgit
    org-plus-contrib
    ob-ipython
    ox-reveal
    ox-asciidoc
    pandoc-mode
    projectile
    solarized-theme
    smart-mode-line
    smart-mode-line-powerline-theme
    smartparens
    smooth-scroll
    smooth-scrolling
    stripe-buffer
    twittering-mode
    volatile-highlights
    yasnippet
    yaml-mode
    zenburn-theme)
  "A list of packages to ensure are installed at launch.")

;; Method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; If not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
                                        ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
                                        ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; exec-path-from-shell
;; Library to ensure environment variables inside Emacs look the same as in the user's shell.
(exec-path-from-shell-initialize)

;; Set org-babel to load the rest of the config
(org-babel-load-file
 (expand-file-name "~/.emacs.d/emacs-init.org"
                   user-emacs-directory))

;; Initialize Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
