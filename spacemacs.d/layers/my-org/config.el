;; Orb-babel settings
;; As org-babel is installed by default with org-mode, it
;; does not have a package to be loaded throughmy spacemacs layer <my-org>. When
;; there is something that has to be loaded but it doesn't have a package
;; related to, it can be loaded through this config.el that has to be created
;; inside the referred layer directory.

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote (
         (calc . t)
         (clojure . t)
         (ditaa . t)
         (dot . t)
         (emacs-lisp . t)
         (gnuplot . t)
         (latex . t)
         (ledger . t)
         (octave . t)
         (org . t)
         (makefile . t)
         (plantuml . t)
         (python . t)
         (R . t)
         (ruby . t)
         (sh . t)
         (sqlite . t)
         (sql . nil))))

;;(setq org-babel-python-command "python2")

(setq org-confirm-babel-evaluate nil)
