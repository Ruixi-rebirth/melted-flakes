{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";

  networking = {
    hostName = "RuiXi"; # Define your hostname.
    networkmanager.enable = true;
    hosts = {
      "185.199.109.133" = [ "raw.githubusercontent.com" ];
      "185.199.111.133" = [ "raw.githubusercontent.com" ];
      "185.199.110.133" = [ "raw.githubusercontent.com" ];
      "185.199.108.133" = [ "raw.githubusercontent.com" ];
    };
  };
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
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
  users.users.${user} = {
    initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = with pkgs; [
      tdesktop
      pkgs.sway-contrib.grimshot
      imagemagick
    ];
  };
  environment = {
    persistence."/nix/persist/" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager"
        "/etc/v2raya"
        "/var/log"
        "/var/lib"
      ];
      users.ruixi = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          ".cache"
          "Codelearning"
          ".npm-global"
          ".config"
          "Flakes"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
      };
    };
    variables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      QT_QPA_PLATFORMTHEME = "gtk2";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      #GBM
      GBM_BACKEND = "nvidia-drm";
      CLUTTER_BACKEND = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      #vulkan
      #WLR_RENDERER="vulkan";
      #__NV_PRIME_RENDER_OFFLOAD="1";

      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_DESKTOP = "sway";
    };

    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      libnotify
      git
      neovim
      wget
      neofetch
      wl-clipboard
      wireplumber
      pipewire-media-session
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      lsd
      gcc
      clang
      cargo
      zig
      p7zip
      atool
      unzip
      ranger
      pcmanfm
      # ffmpeg
      ffmpeg_5
      ffmpegthumbnailer
      glib
      xdg-utils
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      pciutils
      gdb
      ntfs3g
      killall
      nodejs
    ];
  };
  services.gvfs.enable = true;
  services.dbus.enable = true;
  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      ruixi ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

  nix = {
    settings = {
      # substituters = [
      #   "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      #   "https://cache.nixos.org/"
      # ];
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };
}
