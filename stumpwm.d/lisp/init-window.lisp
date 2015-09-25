(in-package :stumpwm)

;;----------------------------------------------------------------------------
;; basic settings
;;----------------------------------------------------------------------------
;; set window display style
(setf *window-format* "%m%n. %60t"
      *maxsize-border-width* 0
      *transient-border-width* 0
      *normal-border-width* 0
      *window-border-style* :none
      *float-window-title-height* 0
      stumpwm.floating-group::*float-window-title-height* 0
      stumpwm.floating-group::*float-window-border* 0)

(set-bg-color "#2b303b")
(set-fg-color "#89ebca")
(set-border-color "#4f5b66")
(set-float-focus-color "#333d46")
(set-float-unfocus-color "#4f5b66")


;; mode line
(setf *screen-mode-line-format* "[%g]  %v  %20d"
      *time-modeline-string* "%Y/%m/%d ^B%H:%M^b"
      *mode-line-border-width* 0
      *mode-line-pad-x* 2
      *mode-line-pad-y* 0)

(define-key *top-map* (kbd "s-b") "mode-line")


;;----------------------------------------------------------------------------
;; global window list
;;----------------------------------------------------------------------------
(defcommand global-windowlist (&optional (fmt *window-format*)
                                         window-list) (:rest)
                                         "Select window from global window list."
                                         (let ((window-list (or window-list (global-window-list))))
                                           (if (null window-list)
                                               (message "No Managed Windows")
                                               (let ((window (select-window-from-menu window-list fmt)))
                                                 (if window
                                                     (global-switch-to-window window)
                                                     (throw 'error :abort))))))


;;----------------------------------------------------------------------------
;; globally switch to previous window
;;----------------------------------------------------------------------------
(defvar *global-previous* '())
(defvar *global-current* '())

(defun remember-focus-window-hook (new old)
  (setf *global-previous* *global-current*)
  (setf *global-current* new))

(add-hook *focus-window-hook* 'remember-focus-window-hook)

(defcommand global-previous () ()
            "Switch to the previous window (possibly from another group) that had focus"
            (let*
                ((window *global-previous*)
                 (group (if window (window-group window)))
                 (frame (ignore-errors (window-frame window))))
              (when (and window (not (= 0 (window-state window))))
                (gselect group)
                (and frame (focus-frame group frame))
                (focus-window window))))


;;----------------------------------------------------------------------------
;; toggle window maximize(don't cover the mode line)
;;----------------------------------------------------------------------------
(defun topbar-height ()
  "Get the height of the top bar(or mode line).
If no top bar exists return 0."
  (let ((mode-line (head-mode-line (current-head))))
    (if mode-line (mode-line-height mode-line) 0)))

;; store window status in a custom list.
(defvar *window-status-list* '())

(defun windows/find (window)
  "Find a window in the window stack."
  (find window *window-status-list* :test (lambda (a b) (eql (gethash 'obj b) a))))

(defun windows/put (window)
  "Push/update a window into/in the window stack."
  (let ((existed (windows/find window))
        ;; create a new object to store window info
        (obj (make-hash-table)))
    ;; set window info
    (dolist (it `((obj . ,window)
                  (x . ,(window-x window))
                  (y . ,(window-y window))
                  (w . ,(window-width window))
                  (h . ,(window-height window))))
      (setf (gethash (car it) obj) (cdr it)))
    (if existed
        (setf (nth (position existed *window-status-list*) *window-status-list*) obj)
        (push obj *window-status-list*))))

(defcommand toggle-window-maximize (&optional window) ()
            (let* ((window (or window (current-window)))
                   (screen (current-screen))
                   (existed (windows/find window)))
              (if (or (window-maximized-p window))
                  (progn
                    (if existed
                        (stumpwm.floating-group::float-window-move-resize
                         window
                         :x      (gethash 'x existed)
                         :y      (gethash 'y existed)
                         :width  (gethash 'w existed)
                         :height (gethash 'h existed))
                        (stumpwm.floating-group::float-window-move-resize
                         window :x 500 :y 200 :width 800 :height 600))
                    (windows/put window))
                  (progn
                    (windows/put window)
                    (stumpwm.floating-group::float-window-move-resize
                     window
                     :x      0
                     :y      (topbar-height)
                     :width  (screen-width screen)
                     :height (- (screen-height screen) (topbar-height)))))))


;;----------------------------------------------------------------------------
;; scroll other window
;;----------------------------------------------------------------------------
(defun other-window-click (button)
  "Send mouse click event to other window."
  (let* ((other-win (next-visible-window)))
    (when other-win
      (send-fake-click other-win button))))

(defcommand other-window-scroll-down () ()
            "Scroll other window down."
            (other-window-click 5))

(defcommand other-window-scroll-up () ()
            "Scroll other window up."
            (other-window-click 4))


;;----------------------------------------------------------------------------
;; other tricks
;;----------------------------------------------------------------------------
(defcommand generic-window-fullscreen () ()
            "Toggle tile/float window fullscreen."
            (fullscreen))

(defcommand hide-this-window () ()
            "Hide current window."
            (let* ((group (current-group))
                   (wins (group-windows group))
                   (win (current-window))
                   (other-win (next-visible-window)))
              (when win
                (hide-window win)
                (no-focus group win)
                (when other-win
                  (group-focus-window group other-win)))))


;;----------------------------------------------------------------------------
;; map keys
;;----------------------------------------------------------------------------
(map-keys *top-map* '(("s-w"    "global-windowlist")
                      ("s-g"    "grouplist")
                      ("s-TAB"  "global-previous")
                      ("s-C-BackSpace"  "delete")
                      ("F11"    "generic-window-fullscreen")
                      ;; minimize/maximize
                      ("s-n"    "hide-this-window")
                      ("s-N"    "pull-hidden-other")
                      ("s-m"    "toggle-window-maximize")
                      ;; move between groups
                      ("C-s-Left"   "gprev-with-window")
                      ("C-s-Right"  "gnext-with-window")
                      ;; Scroll other window
                      ("C-s-v" "other-window-scroll-down")
                      ("C-s-b" "other-window-scroll-up")))

(map-keys *root-map* '(("w"    "global-windowlist")
                       ;; emacs style window shortcuts
                       ("1"    "only")
                       ("2"    "vsplit")
                       ("3"    "hsplit")
                       ("4"    "kill")
                       ("0"    "delete")
                       ("I"    "list-window-properties")
                       ("s-z"  "other")))

;; position control
(map-keys *tile-group-top-map*
          '(;; position exchange
            ("s-S-Up"       "exchange-direction up")
            ("s-S-Down"     "exchange-direction down")
            ("s-S-Left"     "exchange-direction left")
            ("s-S-Right"    "exchange-direction right")
            ;; frame control
            ("s-BackSpace"  "remove")))


;;----------------------------------------------------------------------------
;; group control
;;----------------------------------------------------------------------------
(defcommand move-this-window-to-group-n (group-number)
  ((:number "Please input the target group number: "))
  "Move current window to nth group."
  (let ((win (current-window)))
    (dolist (group (screen-groups (current-screen)))
      (when (= (group-number group) group-number)
        (return (progn (move-window-to-group win group)
                       (switch-to-group group)
                       (raise-window win)))))))

(map-keys *top-map* '(;; switch group
                      ("s-1"      "gselect 1")
                      ("s-2"      "gselect 2")
                      ("s-3"      "gselect 3")
                      ("s-4"      "gselect 4")
                      ("s-5"      "gselect 5")
                      ("s-6"      "gselect 6")
                      ("s-7"      "gselect 7")
                      ("s-8"      "gselect 8")
                      ("s-9"      "gselect 9")
                      ("s-Right"  "gnext")
                      ("s-Left"   "gprev")
                      ("s-C-Up"   "gnew-float")
                      ("s-Up"     "gnew")
                      ("s-Down"   "gkill")
                      ;; move window to group
                      ("s-!"      "move-this-window-to-group-n 1")
                      ("s-@"      "move-this-window-to-group-n 2")
                      ("s-#"      "move-this-window-to-group-n 3")
                      ("s-$"      "move-this-window-to-group-n 4")
                      ("s-%"      "move-this-window-to-group-n 5")
                      ("s-^"      "move-this-window-to-group-n 6")
                      ("s-&"      "move-this-window-to-group-n 7")
                      ("s-*"      "move-this-window-to-group-n 8")
                      ("s-("      "move-this-window-to-group-n 9")))

;; group title format
(setf *group-format* "%t")

;; initialize my groups
(defun setup-my-groups ()
  "Setup my groups."
  (switch-to-group (nth-group 0))

  ;; kill all other groups
  (kill-other-groups)

  ;; create groups
  (grename       "1. Emacs")
  (gnewbg        "2. Term")
  (gnewbg-float  "3. Net")
  (gnewbg-float  "4. Files")
  (gnewbg-float  "5. Media")
  (switch-to-group (nth-group 0)))

(setup-my-groups)


;; specify window rules and handlers
(add-window-handler '(:class "Notify-osd")
                    (lambda (win rules) (unfocus win rules) (move-window-to-corner "top right" win)))
