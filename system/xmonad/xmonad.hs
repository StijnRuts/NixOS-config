import XMonad
import XMonad.Config.Xfce
import XMonad.Config.Azerty

main :: IO ()
main = xmonad $ xfceConfig
  { modMask = mod4Mask -- Super key
  , terminal = "wezterm"
  , keys = myKeys
  }

myKeys c = azertyKeys c <> keys xfceConfig c
