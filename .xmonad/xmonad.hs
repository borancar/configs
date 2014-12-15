-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce

main = xmonad $ kde4Config
  {
    modMask = mod4Mask
  , manageHook = manageHook kde4Config <+> myManageHook
  }
  where
    myManageHook = composeAll
      [
        className =? "Plasma-desktop" --> doFloat
      , className =? "Plasma" --> doFloat
      , className =? "Kcalc" --> doFloat
      ]

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig
