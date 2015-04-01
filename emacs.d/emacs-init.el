
(when (window-system)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'python-mode)

(set-frame-font "Source Code Pro-13")
(load-theme 'solarized-dark t)
;(load-theme 'zenburn)
;(load-theme 'naquadah t)
;(load-theme 'misterioso t)

(toggle-frame-fullscreen)

;; Check if system is Mac or Linux for keeping compatibility
(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))

(defun system-is-linux ()
  (interactive)
  (string-equal system-type "gnu/linux"))

;; set command key to be meta instead of option
(if (system-is-mac)
   (setq ns-command-modifier 'meta))

(setenv "LANG" "en_US")       ; set languase to en_US - solve ESS warning messages

;; Set default coding system to Unicode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-visual-line-mode t)   ;; breaks line text to other line
(delete-selection-mode t)     ;; deletes text select when typed over
(blink-cursor-mode t)         ;; blinking cursor

(setq make-backup-files nil)          ;; disables backup files
(setq auto-save-default t)            ;; disable auto-save
(setq-default tab-width 2)            ;; sets tab to 2
(setq-default indent-tabs-mode nil)   ;; use spaces (not tabs)
(fset 'yes-or-no-p 'y-or-n-p)         ;; requires just y or n
(setq x-select-enable-clipboard t)    ;; kill-ring accepts system clipboard

(setq echo-keystrokes 0.1
    use-dialog-box nil
    visible-bell t)

;; Temporary files management
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(which-function-mode t)               ;; show the current function
(global-prettify-symbols-mode t)       ;; use mathematical Unicode symbols instead of expressions
(add-hook 'prog-mode-hook 'linum-mode) ;; line number only on programming modes
(add-hook 'before-save-hook 'whitespace-cleanup) ;; remove trailing whitespace before saving file

;; set browser as the default browser on the system (for mac)
(setq browse-url-browser-function 'browse-url-default-macosx-browser)

(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "autopair" '(diminish 'autopair-mode))
(eval-after-load "abbrev" '(diminish 'abbrev-mode "Abv"))
(eval-after-load "company" '(diminish 'company-mode))
(eval-after-load "js2-highlight-vars" '(diminish 'js2-highlight-vars-mode))
(eval-after-load "projectile" '(diminish 'projectile-mode))
(eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode))
(eval-after-load "anzu" '(diminish 'anzu-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "magit" '(diminish 'magit-auto-revert-mode))

(anzu-mode +1)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

(sml/setup)
(sml/apply-theme 'automatic)
;; abbreviate folder names
(add-to-list 'sml/replacer-regexp-list '("^~/Projects" ":Proj:") t)
(add-to-list 'sml/replacer-regexp-list '("^:Proj:/git" ":Git:") t)
(add-to-list 'sml/replacer-regexp-list '("^:Git:/dotfiles" ":Dot:") t)
(add-to-list 'sml/replacer-regexp-list '("^:Dot:/emacs.d" ":ED:") t)
(add-to-list 'sml/replacer-regexp-list '("^~/Copy" ":CP:") t)

(global-aggressive-indent-mode 1)

(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-global-mode t)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

;; evil-smartparens makes smartparens and evil-mode play nicely together
;;(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

(yas-global-mode t)

(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)
;(require 'flycheck-tip)
;(flycheck-tip-use-timer 'verbose)
(add-hook 'prog-mode-hook 'flycheck-mode)

;(defun iedit-dwim (arg)
;  "Starts iedit but uses \\[narrow-to-defun] to limit its scope."
;  (interactive "P")
;  (if arg
;      (iedit-mode)
;    (save-excursion
;      (save-restriction
;        (widen)
;        ;; this function determines the scope of `iedit-start'.
;        (if iedit-mode
;            (iedit-done)
;          ;; `current-word' can of course be replaced by other
;          ;; functions.
;          (narrow-to-defun)
;          (iedit-start (current-word) (point-min) (point-max)))))))
;
;(global-set-key (kbd "C-;") 'iedit-dwim)

;; Fixing a key binding bug between iedit mode and yelp-mode (Python)
;(define-key global-map (kbd "C-c o") 'iedit-mode)

(if (system-is-mac)
    (autoload 'dash-at-point "dash-at-point"
              "Search the word at point with Dash." t nil)
    (global-set-key "\C-cd" 'dash-at-point)
    (global-set-key "\C-ce" 'dash-at-point-with-docset))

(require 'dired+)
(setq dired-recursive-deletes (quote top))
(define-key dired-mode-map (kbd "f") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda ()
                                       (interactive)
                                       (find-alternate-file "..")))

;;Stripe Dired buffers
(require 'stripe-buffer)
(add-hook 'org-mode-hook 'org-table-stripes-enable)
(add-hook 'dired-mode-hook 'stripe-listify-buffer)

(set-default 'magit-stage-all-confirm nil)
(add-hook 'magit-mode-hook 'magit-load-config-extensions)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g h") 'magit-log)
(global-set-key (kbd "C-x g f") 'magit-file-log)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
(global-set-key (kbd "C-x g m") 'magit-branch-manager)
(global-set-key (kbd "C-x g c") 'magit-branch)
(global-set-key (kbd "C-x g s") 'magit-status)
(global-set-key (kbd "C-x g r") 'magit-reflog)
(global-set-key (kbd "C-x g t") 'magit-tag)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(add-hook 'js-mode-hook (lambda ()
                          (when (string-match "conkeror" (buffer-file-name))
                            (conkeror-minor-mode 1))))

(require 'org-protocol)
(require 'org-bullets)
(require 'org-notmuch)
(require 'ox-latex)
(require 'ox-beamer)
(require 'ox-odt)
(require 'ox-html)
(require 'ox-deck)
(require 'ox-publish)
(require 'ox-bibtex)
(require 'ox-koma-letter)
(require 'ox-reveal)

(setq org-export-with-smart-quotes t)
'(org-cycle-include-plain-lists t)
'(org-alphabetical-lists t)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-hide-leading-stars t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; languages supported
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
;(setq org-babel-python-command "python2")

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(setq org-confirm-babel-evaluate nil)

(setq org-src-window-setup 'current-window)

(setq org-archive-location "~/Copy/Org/archive.org::From %s")

(setq org-directory "~/Copy/Org")
(setq org-mobile-directory "~/Copy/MobileOrg")
;; Set to the files (or directory of files) you want sync'd
(setq org-agenda-files (quote ("~/Copy/Org")))
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Copy/Org/from-mobile.org")

(setq org-latex-create-formula-image-program 'imagemagick)

(add-to-list 'org-latex-packages-alist '("" "minted"))
 (setq org-latex-listings 'minted)

 ;; This defines the variables minted uses for beautiful code-blocks.
 ;; Without this, the code-blocks will just look like inline text.
 (setq org-latex-minted-options
       '(("frame" "lines")
         ("framesep" "2mm")
         ("baselinestretch" "1.2")
         ("bgcolor" "mintedbg")
         ("mathescape" "true")
         ("linenos" "")
         ("fontsize" "\\footnotesize")))

 ;; LaTeX compilation command. For orgmode docs we just always use xelatex for convenience.
 ;; You can change it to pdflatex if you like, just remember to make the adjustments to the packages-alist below.
 (setq org-latex-pdf-process
       '("latexmk -pdflatex='xelatex -synctex=1 --shell-escape' -pdf %f"))

 ;; Sets the structure of the document to be Latex Koma-article by default
 (unless (boundp 'org-latex-classes)
       (setq org-latex-classes nil))
 (add-to-list 'org-latex-classes
              '("koma-article"
                "\\documentclass{scrartcl}"
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

 ;; To use the stardard Latex article design the class has to be included in the org file as:
 ;; #+LaTeX_CLASS: article
 ;; source: http://orgmode.org/worg/org-tutorials/org-latex-export.html
 (add-to-list 'org-latex-classes
              '("article"
                "\\documentclass{article}"
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; As above, but to use Memoir design, set memarticle in the org file
 (add-to-list 'org-latex-classes
              '("memarticle"
                "\\documentclass{memoir}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(require 'helm)
(require 'helm-config)

(helm-autoresize-mode t)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; Semantic-mode provides language-aware editing commands based on 'source code parsers'.
;; To activate it through helm-semantic-or-imenu press C-c-h-i
(semantic-mode 1)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)

;; Helm-company - Helm interface for company-mode
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)
(setq projectile-enable-caching t)

(setq TeX-open-quote "“")
(setq TeX-close-quote "”")

;; Synctex with Skim
(add-hook 'TeX-mode-hook
(lambda ()
(add-to-list 'TeX-output-view-style
'("^pdf$" "."
 "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))))

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

;; Make emacs aware of multi-file projects
;; (setq-default TeX-master nil)

;; Auto-raise Emacs on activation (from Skim, usually)
(defun raise-emacs-on-aqua()
(shell-command "osascript -e 'tell application \"Emacs\" to activate' &"))
(add-hook 'server-switch-hook 'raise-emacs-on-aqua)

;; AucTeX
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode t)

  ;; Use Skim as viewer, enable source <-> PDF sync
  ;; make latexmk available via C-c C-c
  ;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;  (add-hook 'LaTeX-mode-hook (lambda ()
;  (push
;  '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;  :help "Run latexmk on file")
;  TeX-command-list)))
;  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

  ;; use Skim as default pdf viewer
  ;; Skim's displayline is used for forward search (from .tex to .pdf)
  ;; option -b highlights the current line; option -g opens Skim in the background
;  (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
;  (setq TeX-view-program-list
;  '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))

(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'TeX-mode-hook 'pandoc-mode)
(add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

(require 'notmuch)     ; loads notmuch package
(setq message-kill-buffer-on-exit t) ; kill buffer after sending mail)
(setq mail-specify-envelope-from t) ; Settings to work with msmtp
                                        ;  (setq message-sendmail-envelope-from header)
                                        ;  (setq mail-envelope-from header)
(setq notmuch-fcc-dirs "sent-mail") ; stores sent mail to the specified directory
(setq message-directory "drafts") ; stores postponed messages to the specified directory

;; Completion selection with helm
(setq notmuch-address-selection-function
      (lambda (prompt collection initial-input)
        (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

;; Customized searches
(setq notmuch-saved-searches '((:name "inbox"
                                      :query "tag:inbox and not tag:delete"
                                      :count-query "tag:inbox and tag:unread"
                                      :sort-order 'oldest-first)
                               (:name "classes"
                                      :query "tag:classes and not tag:delete"
                                      :count-query "tag:classes and tag:unread")))

;; Set a global binding to call elfeed
(global-set-key (kbd "C-x w") 'elfeed)

;; Using elfeed-org to manage the feeds instead of the default from elfeed.
;; Elfeed-org is more flexible and easy to use.
;; Load elfeed-org
(require 'elfeed-org)

;; Initialize elfeed-org
;; This hooks up elfeed-org to read the configuration when elfeed
;; is started with =M-x elfeed=
(elfeed-org)

;; Optionally specify a number of files containing elfeed
;; configuration. If not set then the location below is used.
;; Note: The customize interface is also supported.
(setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org"))

;; Setting Python path allowing elpy to find it
;(setenv "PYTHONPATH" "/usr/local/bin/python")

;; Enable elpy
(when (require 'elpy nil t)
  (elpy-enable))

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;(autoload 'jedi:setup "jedi" nil t)

;; Default keyboard shortcuts
(setq jedi:setup-keys t)

;; To complete on the “.” (when type some object or module name and a “.” it gives all the possible attributes/submodules/methods/etc)
(setq jedi:complete-on-dot t)

;; Setting Jedi as elpy backend
(setq elpy-rpc-backend "jedi")

;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)

;; Type:
;;     M-x package-install RET jedi RET
;;     M-x jedi:install-server RET
;; Then open Python file.

;(elpy-use-ipython)

;; Make Elpy work well with org-mode
;; check: https://github.com/jorgenschaefer/elpy/issues/191
;; https://github.com/jorgenschaefer/elpy/wiki/FAQ#q-how-do-i-make-elpy-work-well-with-org-mode
;; http://lists.gnu.org/archive/html/emacs-orgmode/2013-12/msg00063.html
;; https://lists.gnu.org/archive/html/emacs-orgmode/2015-01/msg00578.html

(setq org-babel-python-command "ipython --pylab=osx --pdb --nosep
                      --classic --no-banner --no-confirm-exit")

(defadvice org-babel-python-evaluate
    (around org-python-use-cpaste
            (session body &optional result-type result-params preamble) activate)
    "Add a %cpaste and '--' to the body, so that ipython does the right thing."
    (setq body (concat "%cpaste -q\n" body "\n--\n"))
    ad-do-it
    (if (stringp ad-return-value)
        (setq ad-return-value (replace-regexp-in-string "\\(^Pasting code; enter '--' alone on the line to stop or use Ctrl-D\.[\r\n]:*\\)" ""
                                                        ad-return-value))))

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--pylab=osx --pdb --nosep --classic --no-banner"
      python-shell-prompt-regexp ">>> "
      python-shell-prompt-output-regexp ""
      python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
      python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
      python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
      )

(setq ess-ask-for-ess-directory nil)
(setq inferior-R-program-name "/usr/local/bin/R")
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(setq ess-eval-visibly nil)
(require 'ess-site)

(setq-default fill-column 80) ;; set 80 column display as default

(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "saveplace.el"))
(setq-default save-place t)

(defun select-current-line ()
   "Selects the current line"
   (interactive)
   (end-of-line)
   (push-mark (line-beginning-position) nil t))

;   (key-chord-define-global ".l" 'select-current-line)

(defun line-above()
   "Pastes line above"
   (interactive)
   (move-beginning-of-line nil)
   (newline-and-indent)
   (forward-line -1)
   (indent-according-to-mode))

;   (key-chord-define-global ".a" 'line-above)

(defun cut-line-or-region()
   ""
   (interactive)
   (if (region-active-p)
       (kill-region (region-beginning) (region-end))
     (kill-region (line-beginning-position) (line-beginning-position 2))))

;   (key-chord-define-global ".x" 'cut-line-or-region)

(defun copy-line-or-region()
   ""
   (interactive)
   (if (region-active-p)
       (kill-ring-save (region-beginning) (region-end))
     (kill-ring-save (line-beginning-position) (line-beginning-position 2))))

;   (key-chord-define-global ".c" 'copy-line-or-region)

(defun duplicate-current-line-or-region (arg)
   "Duplicates the current line or region ARG times.
 If there's no region, the current line will be duplicated. However, if
 there's a region, all lines that region covers will be duplicated."
   (interactive "p")
   (let (beg end (origin (point)))
     (if (and mark-active (> (point) (mark)))
         (exchange-point-and-mark))
     (setq beg (line-beginning-position))
     (if mark-active
         (exchange-point-and-mark))
     (setq end (line-end-position))
     (let ((region (buffer-substring-no-properties beg end)))
       (dotimes (i arg)
         (goto-char end)
         (newline)
         (beginning-of-visual-line)
         (insert region)
         (setq end (point)))
       (goto-char (+ origin (* (length region) arg) arg)))))

;   (key-chord-define-global ".d" 'duplicate-current-line-or-region)
