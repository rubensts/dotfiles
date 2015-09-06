;;; init.el --- Summary
;;; Commentary:
;; Configuration file for Emacs

;;; Code:

;; custom-set-variables has to be placed at the beginning of init.el to avoid
;; warnings about “Loading themes can run lisp code” and “Would you like to mark
;; this theme as safe for future sessions?”.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "44f015a4c080c3943bc1d9428ccd70caa7c54eceeb68b7f53e7adef961880ad8" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "f77b66fa762568d66fc00a5e2013aae76d78f0142669c55b7eb3c8e5d4d41e7d" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "19352d62ea0395879be564fc36bc0b4780d9768a964d26dfae8aad218062858d" default)))
 '(paradox-automatically-star t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
    langtool
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
    ox-asciidoc
    ox-pandoc
    ox-reveal
    paradox
    projectile
    solarized-theme
    smart-mode-line
    smart-mode-line-powerline-theme
    smartparens
    smooth-scroll
    smooth-scrolling
    stripe-buffer
    twittering-mode
    vagrant
    vagrant-tramp
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
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
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
