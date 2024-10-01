import XMonad
import XMonad.Config.Kde

main :: IO ()
main = xmonad $ kde4Config -- Same for Plasma 5 and 6
  { modMask = mod4Mask -- Super key
  , borderWidth = 1
  , terminal = "wezterm"
  , normalBorderColor = "#3c3836"
  , focusedBorderColor = "#fabd2f"
  }
