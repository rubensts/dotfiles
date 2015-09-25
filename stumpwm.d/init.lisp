;; configuration shamelessly taken from (Sep 25th, 2015):
;; https://github.com/qizhihere/.stumpwm.d/blob/master/init.lisp
;;
;; It divides StumpWM in various files placed on lisp/ directory

(require :stumpwm)
(in-package :stumpwm)

;; stumpwm configuration directory
(defvar *config-directory* (directory-namestring *load-truename*))

(defun load-conf (filename)
  "Load a file FILENAME in ~/.stumpwm.d/lisp."
  (let ((file (merge-pathnames (concat "lisp/" filename ".lisp")
                               *config-directory*)))
    (if (probe-file file)
        (load file)
        (format *error-output* "File '~a' doesn't exist." file))))

(load-conf "init-utils")
(load-conf "init-swank")
;;(load-conf "init-basic")
;;(load-conf "init-system")
(load-conf "init-window")
;;(load-conf "init-app")
