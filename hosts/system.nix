{ config, pkgs, lib, inputs, user, ... }:

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
      TERMINAL = "kitty";
      EDITOT = "nvim";

    };
    systemPackages = with pkgs; [
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

