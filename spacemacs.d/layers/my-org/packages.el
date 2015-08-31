;;; packages.el --- my-org Layer packages File for Spacemacs
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

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.

;; The org-plus-contrib package holds many interesting org packages that were
;; not inserted yet as standalone packages, thus they are automaticaly installed
;; in ~/.emacs.d/elpa/org-plus-contrib-<date> once org-plus-contrib is
;; installed. They have to be called in the <my-org>extensions.el file.

(setq my-org-packages
    '(
      org-plus-contrib
      ox-pandoc
      ox-reveal
      ))

;; List of packages to exclude.
(setq my-org-excluded-packages '())

;; List of packages to be initialized.

(defun my-org/init-org-plus-contrib ()
  "Initialize org-plus-contrib"
  (use-package org-plus-contrib
    :defer t)
  )

(defun my-org/init-ox-pandoc ()
  "Initialize ox-pandoc"
  (use-package ox-pandoc
    :defer t)
  )

(defun my-org/init-ox-reveal ()
  "Initialize ox-reveal"
  (use-package ox-reveal
    :defer t)
  )
