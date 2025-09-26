(in-package #:nyxt-user)

(nyxt::load-lisp "~/.config/nyxt/stylesheet.lisp")

;; Use the Catppuccin theme
;; (define-configuration browser
;;   ((theme (catppuccin-theme 'mocha 'yellow))))

;; Use the Catppuccin theme, with a custom font
(define-configuration browser
  ((theme (catppuccin-theme
    'mocha 'yellow
    :font-family "Ubuntu"
    :monospace-font-family "UbuntuMono Nerd Font"))))

;; Use the Catppuccin dark mode
(define-configuration nyxt/mode/style:dark-mode
  ((style (catppuccin-dark-mode 'mocha 'yellow))))

;; Enable dark mode by default
(define-configuration web-buffer
  ((default-modes
    (pushnew 'nyxt/mode/style:dark-mode %slot-value%))))




;;(define-configuration buffer
;;  ((default-modes (append '(nyxt/mode/dark:dark-mode) %slot-value%))))

;;(define-configuration web-buffer
;;  ((default-modes
;;    (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

;;(define-configuration web-buffer
;;  ((default-modes
;;    (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-value%))))
