-- Imports.
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.StackSet as W
import XMonad.Operations
import XMonad.Layout.NoBorders

--
-- -- The main function.
main = xmonad myConfig
--
-- -- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
  modMask = mod4Mask, -- Alledgedly this uses super instead of alt
  layoutHook = smartBorders $ layoutHook defaultConfig
} `additionalKeys`
  [
    ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer -D pulse set Master 1+ toggle")
    , ((0, 0x1008FF02), spawn "xbacklight -inc 5")
    , ((0, 0x1008FF03), spawn "xbacklight -dec 5")
       -- aptitude install scrot
       --take a screenshot of entire display
    , ((mod4Mask , xK_Print ), spawn "filename=Pictures/screen_$(date +%Y-%m-%d-%H-%M-%S).png && scrot ${filename} -d 1 && pinta ${filename}")
       --take a screenshot of focused window
    , ((mod4Mask .|. shiftMask, xK_Print ), spawn "filename=Pictures/window_$(date +%Y-%m-%d-%H-%M-%S).png && scrot ${filename} -d 1 -u && pinta ${filename}")
       -- quick lock
    , ((0,  xK_Scroll_Lock), spawn "slock")
    , ((mod4Mask,  xK_x), spawn "slock")
    , ((mod4Mask .|. shiftMask,  xK_x), spawn "slock & systemctl suspend")
    , ((mod4Mask,  xK_c), spawn "filename=Pictures/window_$(date +%Y-%m-%d-%H-%M-%S).png && scrot ${filename} -d 1 -u && pinta ${filename}")
       -- re-tile a floating window
    , ((mod4Mask, xK_t), withFocused $ windows . W.sink)

  ]
--
