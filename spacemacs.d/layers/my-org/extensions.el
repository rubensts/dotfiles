;;; extensions.el --- my-org Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq my-org-pre-extensions
      '(
        ;; post extension names go here
        ))

;; All this packages are installed through the package org-plus-contrib.
;; They can only be called after org-plus-contrib is installed.
(setq my-org-post-extensions
      '(
        org-protocol
        org-notmuch
        org-drill
        ox-latex
        ox-ascii
        ox-beamer
        ox-odt
        ox-html
        ox-deck
        ox-publish
        ox-bibtex
        ox-koma-letter
        ))

;; For each extension, define a function my-org/init-<extension-name>
;;

(defun my-org/init-org-protocol ()
  "Initialize org-protocol"
  (use-package org-protocol
    :defer t)
  )

(defun my-org/init-org-notmuch ()
  "Initialize org-notmuch"
  (use-package org-notmuch
    :defer t)
  )

(defun my-org/init-org-drill ()
  "Initialize org-drill"
  (use-package org-drill
    :defer t)
  )

(defun my-org/init-ox-latex ()
  "Initialize ox-latex"
  (use-package ox-latex
    :defer t)
  )

(defun my-org/init-ox-ascii ()
  "Initialize ox-ascii"
  (use-package ox-ascii
    :defer t)
  )

(defun my-org/init-ox-beamer ()
  "Initialize ox-beamer"
  (use-package ox-beamer
    :defer t)
  )

(defun my-org/init-ox-odt ()
  "Initialize ox-odt"
  (use-package ox-odt
    :defer t)
  )

(defun my-org/init-ox-html ()
  "Initialize ox-html"
  (use-package ox-html
    :defer t)
  )

(defun my-org/init-ox-deck ()
  "Initialize ox-deck"
  (use-package ox-deck
    :defer t)
  )

(defun my-org/init-ox-publish ()
  "Initialize ox-publish"
  (use-package ox-publish
    :defer t)
  )

(defun my-org/init-ox-bibtex ()
  "Initialize ox-bibtex"
  (use-package ox-bibtex
    :defer t)
  )

(defun my-org/init-ox-koma-letter ()
  "Initialize ox-koma-letter"
  (use-package ox-koma-letter
    :defer t)
  )

;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
