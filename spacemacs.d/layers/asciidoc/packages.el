;;; packages.el --- asciidoc Layer packages File for Spacemacs
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
(setq asciidoc-packages
    '(
      adoc-mode
      ox-asciidoc
      ))

;; List of packages to exclude.
(setq asciidoc-excluded-packages '())

;; For each package, define a function asciidoc/init-<package-asciidoc>
;;
(defun asciidoc/init-adoc-mode ()
  "Initialize adoc-mode"
  (use-package adoc-mode)
  )

(defun asciidoc/init-ox-asciidoc ()
  "Initialize ox-asciidoc"
  (use-package ox-asciidoc)
  )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
