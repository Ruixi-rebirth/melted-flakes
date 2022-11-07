import XMonad

main = xmonad def
    { terminal    = "kitty"
    , modMask     = mod1Mask
    , borderWidth = 3
    }
