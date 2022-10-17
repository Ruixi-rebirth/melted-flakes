{ config, lib, pkgs, user, ... }:

{
  imports =
    [(import ../../modules/desktop/sway/home.nix)] ++
    (import ../../modules/shell) ++
    (import ../../modules/editors) ++
    (import ../../modules/programs) ++
    (import ../../modules/theme) ++
    (import ../../modules/dev_lang);

#   home.sessionVariables = {
#     EDITOR = "nvim";
#     QT_QPA_PLATFORMTHEME="gtk2";
#     MOZ_ENABLE_WAYLAND=1;
#     GTK_IM_MODULE="fcitx5";
#     QT_IM_MODULE="fcitx5";
#     XMODIFIERS="@im=fcitx5";
#     SDL_VIDEODRIVER="wayland";
#     _JAVA_AWT_WM_NONREPARENTING=1;
#     QT_QPA_PLATFORM="wayland";
#     QT_WAYLAND_DISABLE_WINDOWDECORATION=1;
#     XDG_CURRENT_DESKTOP="sway";
#     XDG_SESSION_DESKTOP="sway";
# #GBM
#     GBM_BACKEND="nvidia-drm";
#     __GLX_VENDOR_LIBRARY_NAME="nvidia";
# #vulkan
# #WLR_RENDERER="vulkan";
# #__NV_PRIME_RENDER_OFFLOAD=1;
#   };
  home = {
    username = "ruixi";
    homeDirectory = "/home/ruixi";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "22.05";
}

