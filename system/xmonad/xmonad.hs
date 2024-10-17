import XMonad
import XMonad.Config.Kde
import XMonad.Config.Azerty
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders

baseConfig = kde4Config -- also for KDE 5 and 6

main :: IO ()
main = xmonad $ baseConfig
  { modMask = mod4Mask -- Super key
  , terminal = "wezterm"
  , layoutHook = myLayouts
  , keys = myKeys
  , normalBorderColor = "#11111b"
  , focusedBorderColor = "#f9e2af"
  }

myLayouts = smartBorders $ smartSpacingWithEdge 5 $ layoutHook baseConfig

myKeys c = azertyKeys c <> keys baseConfig c
