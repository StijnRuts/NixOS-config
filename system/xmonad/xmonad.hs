import XMonad
import XMonad.Config.Kde
import XMonad.Config.Azerty

main :: IO ()
main = xmonad $ kde4Config -- also for KDE 5 and 6
  { modMask = mod4Mask -- Super key
  , keys = myKeys
  }

myKeys c = azertyKeys c <> keys kde4Config c

