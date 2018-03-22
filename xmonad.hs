-- Imports.
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.StackSet as W
import XMonad.Operations
import XMonad.Layout.NoBorders

--
-- -- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
--
-- -- Command to launch the bar.
myBar = "xmobar"
--
-- -- Custom PP, configure it as you like. It determines what is being written
-- to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
--
-- -- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
--
-- -- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
  modMask = mod4Mask, -- Alledgedly this uses super instead of alt
  layoutHook = smartBorders $ layoutHook defaultConfig
} `additionalKeys`
  [
    ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer set Master toggle")
    , ((0, 0x1008FF02), spawn "xbacklight -inc 5")
    , ((0, 0x1008FF03), spawn "xbacklight -dec 5")
       -- aptitude install scrot
       --take a screenshot of entire display
    , ((mod4Mask , xK_Print ), spawn "filename=Pictures/screen_$(date +%Y-%m-%d-%H-%M-%S).png && scrot ${filename} -d 1 && pinta ${filename}")
       --take a screenshot of focused window
    , ((mod4Mask .|. shiftMask, xK_Print ), spawn "filename=Pictures/window_$(date +%Y-%m-%d-%H-%M-%S).png && scrot ${filename} -d 1 -u && pinta ${filename}")
       -- quick lock
    , ((0,  xK_Scroll_Lock), spawn "slock")
       -- re-tile a floating window
    , ((mod4Mask, xK_t), withFocused $ windows . W.sink)

  ]
--
