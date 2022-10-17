{ config, pkgs, lib, inputs, user, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };
in
{
  nixpkgs.system = "x86_64-linux";

  networking.hostName = "RuiXi"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true; 
    };
  };
  users.users.${user} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];  
    packages = with pkgs; [
      tdesktop
      cargo
      pkgs.sway-contrib.grimshot
    ];
  };
  environment = {
    variables = {
     EDITOR = "nvim";
     BROWSER = "firefox";
     TERMINAL = "kitty";
     QT_QPA_PLATFORMTHEME="gtk2";
     MOZ_ENABLE_WAYLAND=1;
     QT_IM_MODULE="fcitx5";
     XMODIFIERS="@im=fcitx5";
     SDL_VIDEODRIVER="wayland";
     _JAVA_AWT_WM_NONREPARENTING=1;
     QT_QPA_PLATFORM="wayland";
     QT_WAYLAND_DISABLE_WINDOWDECORATION=1;
     XDG_CURRENT_DESKTOP="sway";
     XDG_SESSION_DESKTOP="sway";
     #GBM
     GBM_BACKEND="nvidia-drm";
     __GLX_VENDOR_LIBRARY_NAME="nvidia";
     #vulkan
     #WLR_RENDERER="vulkan";
     #__NV_PRIME_RENDER_OFFLOAD=1;
    };
    systemPackages = with pkgs; [
      neovim
      wget
      neofetch
      wl-clipboard
      wireplumber
      pipewire-media-session
      dbus-sway-environment
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      pkgs.libsForQt5.qtstyleplugins
      lsd
      gcc 
      clang
      zig
      p7zip
      atool
      unzip
      ranger
      ffmpegthumbnailer
      glib
      xdg-utils
      pkgs.gnome.nautilus
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      libva-utils
      sshpass
      pciutils
      gdb
      ntfs3g
      linux-firmware
      libva 
      vaapiVdpau 
      mesa
      killall
    ];
  };
  services.dbus.enable = true;
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
# nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}

