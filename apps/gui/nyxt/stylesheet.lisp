(in-package #:nyxt-user)

;; https://github.com/atlas-engineer/nyxt/blob/b6ab389817edfbaecfad1b0e62da204acbd5d641/libraries/theme/README.org
;; https://nyxt.atlas.engineer/article/how-to-theme.org

(defconstant +Rosewater+ "#f5e0dc")
(defconstant +Flamingo+ "#f2cdcd")
(defconstant +Pink+ "#f5c2e7")
(defconstant +Mauve+ "#cba6f7")
(defconstant +Red+ "#f38ba8")
(defconstant +Maroon+ "#eba0ac")
(defconstant +Peach+ "#fab387")
(defconstant +Yellow+ "#f9e2af")
(defconstant +Green+ "#a6e3a1")
(defconstant +Teal+ "#94e2d5")
(defconstant +Sky+ "#89dceb")
(defconstant +Sapphire+ "#74c7ec")
(defconstant +Blue+ "#89b4fa")
(defconstant +Lavender+ "#b4befe")
(defconstant +Text+ "#cdd6f4")
(defconstant +Subtext1+ "#bac2de")
(defconstant +Subtext0+ "#a6adc8")
(defconstant +Overlay2+ "#9399b2")
(defconstant +Overlay1+ "#7f849c")
(defconstant +Overlay0+ "#6c7086")
(defconstant +Surface2+ "#585b70")
(defconstant +Surface1+ "#45475a")
(defconstant +Surface0+ "#313244")
(defconstant +Base+ "#1e1e2e")
(defconstant +Mantle+ "#181825")
(defconstant +Crust+ "#11111b")

(defvar +catppuccin-mocha-yellow-theme+
  (make-instance 'theme:theme
    :dark-p t
    :font-family "Ubuntu"
    :monospace-font-family "UbuntuMono Nerd Font"

    :text-color- +Text+
    :text-color  +Text+
    :text-color+ +Text+
    :contrast-text-color +Base+

    :background-color-   +Surface0+
    :background-color    +Base+
    :background-color+   +Mantle+
    :on-background-color +Text+

    :action-color-   +Yellow+
    :action-color    +Yellow+
    :action-color+   +Yellow+
    :on-action-color +Base+

    :highlight-color-   +Red+
    :highlight-color    +Red+
    :highlight-color+   +Red+
    :on-highlight-color +Base+

    :primary-color-   +Yellow+
    :primary-color    +Yellow+
    :primary-color+   +Yellow+
    :on-primary-color +Base+

    :secondary-color-   +Surface1+
    :secondary-color    +Surface1+
    :secondary-color+   +Surface1+
    :on-secondary-color +Text+

    :success-color-   +Green+
    :success-color    +Green+
    :success-color+   +Green+
    :on-success-color +Base+

    :warning-color-   +Red+
    :warning-color    +Red+
    :warning-color+   +Red+
    :on-warning-color +Base+

    :codeblock-color-   +Surface0+
    :codeblock-color    +Base+
    :codeblock-color+   +Mantle+
    :on-codeblock-color +Text+))

(define-configuration browser
  ((theme +catppuccin-mocha-yellow-theme+)))
