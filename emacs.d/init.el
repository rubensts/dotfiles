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
  '(aggressive-indent
    anzu
    auctex
    bookmark+
    company
    conkeror-minor-mode
    diminish
    dired+
    ein
    elfeed
    elfeed-org
    elpy
    ess
    exec-path-from-shell
    flatui-theme
    flycheck
    flycheck-pyflakes
    helm
    helm-projectile
    jedi
    julia-mode
    leuven-theme
    magit
    markdown-mode
    naquadah-theme
    notmuch
    org
    org-bullets
    org-magit
    org-plus-contrib
    ox-reveal
    pandoc-mode
    projectile
    solarized-theme
    smart-mode-line
    smart-mode-line-powerline-theme
    smartparens
    stripe-buffer
    twittering-mode
    virtualenv
    volatile-highlights
    yasnippet
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
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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
