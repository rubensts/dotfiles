;;; shut-up-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "shut-up" "../../../../../../../../.emacs.d/.cask/24.4.1/bootstrap/shut-up-20140904.44/shut-up.el"
;;;;;;  "59211c0712436d9242aa9ee4f86b0b9a")
;;; Generated autoloads from ../../../../../../../../.emacs.d/.cask/24.4.1/bootstrap/shut-up-20140904.44/shut-up.el

(autoload 'shut-up "shut-up" "\
Evaluate BODY with silenced output.

While BODY is evaluated, all output is redirected to a buffer,
unless `shut-up-ignore' is non-nil.  This affects:

- `message'
- All functions using `standard-output' (e.g. `print', `princ', etc.)

Inside BODY, the buffer is bound to the lexical variable
`shut-up-sink'.  Additionally provide a lexical function
`shut-up-current-output', which returns the current contents of
`shut-up-sink' when called with no arguments.

Changes to the variable `shut-up-ignore' inside BODY does not
have any affect.

\(fn &rest BODY)" nil t)

(put 'shut-up 'lisp-indent-function '0)

(autoload 'shut-up-silence-emacs "shut-up" "\
Silence Emacs.

Change Emacs settings to reduce the output.

WARNING: This function has GLOBAL SIDE-EFFECTS.  You should only
call this function in `noninteractive' sessions.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("../../../../../../../../.emacs.d/.cask/24.4.1/bootstrap/shut-up-20140904.44/shut-up-autoloads.el"
;;;;;;  "../../../../../../../../.emacs.d/.cask/24.4.1/bootstrap/shut-up-20140904.44/shut-up.el")
;;;;;;  (21692 1089 558664 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; shut-up-autoloads.el ends here
