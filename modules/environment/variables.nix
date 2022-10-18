{ config, pkgs, ... }:

{
  home.sessionVariables = {
        EDITOR = "nvim";
     BROWSER = "firefox";
     TERMINAL = "kitty";
     QT_QPA_PLATFORMTHEME="gtk2";
     MOZ_ENABLE_WAYLAND="1";
     SDL_VIDEODRIVER="wayland";
     _JAVA_AWT_WM_NONREPARENTING="1";
     QT_QPA_PLATFORM="wayland";
     QT_WAYLAND_DISABLE_WINDOWDECORATION="1";
     XDG_CURRENT_DESKTOP="sway";
     XDG_SESSION_DESKTOP="sway";
     WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
     #GBM
     GBM_BACKEND="nvidia-drm";
     __GLX_VENDOR_LIBRARY_NAME="nvidia";
     #vulkan
     #WLR_RENDERER="vulkan";
     #__NV_PRIME_RENDER_OFFLOAD="1";
  };
}
