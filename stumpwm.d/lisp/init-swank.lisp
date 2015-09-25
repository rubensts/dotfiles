(in-package :stumpwm)

(require :swank)
(swank-loader:init)

(defvar *swank-server-running* nil)

(defun swank-start-server ()
  (and (not *swank-server-running*)
       (swank:create-server :port 4005
                            :style swank:*communication-style*
                            :dont-close t)
       (setf *swank-server-running* t)))

(defun swank-stop-server ()
  (and *swank-server-running*
       (swank:stop-server 4005)
       (setf *swank-server-running* nil)))

(defcommand start-swank-server () ()
            "Start swank server."
            (swank-start-server))

(defcommand stop-swank-server () ()
            "Stop swank server."
            (swank-stop-server))

;; start server
(swank-start-server)
