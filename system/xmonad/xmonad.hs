import XMonad
import XMonad.Config.Kde
import XMonad.Config.Azerty
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

baseConfig = kde4Config -- also for KDE 5 and 6

main :: IO ()
main = xmonad $ baseConfig
  { modMask = mod4Mask -- Super key
  , layoutHook = myLayouts
  , keys = myKeys
  , normalBorderColor = "#11111b"
  , focusedBorderColor = "#f9e2af"
  }

myLayouts =
  smartBorders $
  smartSpacingWithEdge 3 $
  gaps [(D,36)] $ -- panel height
  layoutHook def

myKeys c = azertyKeys c <> keys baseConfig c

