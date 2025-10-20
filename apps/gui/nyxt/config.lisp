(in-package #:nyxt-user)

;; git clone https://github.com/aartaka/nx-dark-reader.git ~/.local/share/nyxt/extensions/nx-dark-reader
(define-nyxt-user-system-and-load "nyxt-user/dark-reader"
  :depends-on (:nx-dark-reader))

(nyxt::load-lisp "~/.config/nyxt/catppuccin.lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use the Catppuccin theme
;; (catppuccin-theme 'mocha 'yellow)

;; Use the Catppuccin theme, with a custom font
(catppuccin-theme
    'mocha 'yellow
    :font-family "Ubuntu"
    :monospace-font-family "UbuntuMono Nerd Font")

;; This automatically darkens WebKit-native interfaces and sends the
;; "prefers-color-scheme: dark" to all the supporting websites.
(setf (uiop:getenv "GTK_THEME") "Adwaita:dark")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use the Catppuccin dark-mode
(catppuccin-dark-mode 'mocha 'yellow)

;; Enable dark-mode by default
;; (define-configuration web-buffer
;;   ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use the Catppuccin theme for dark-reader
(catppuccin-dark-reader 'mocha 'yellow)

;; Enable dark-reader by default
(define-configuration web-buffer
  ((default-modes (pushnew 'nxdr:dark-reader-mode %slot-value%))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; git clone https://github.com/atlas-engineer/cl-readability.git ~/.local/share/nyxt/extensions/cl-readability

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(define-configuration web-buffer
;;  ((default-modes
;;    (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

;;(define-configuration web-buffer
;;  ((default-modes
;;    (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-value%))))

;; (define-configuration browser
;;   ((default-new-buffer-url (quri:uri "https://github.com/atlas-engineer/nyxt"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
