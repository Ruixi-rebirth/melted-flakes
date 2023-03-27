{ config, pkgs, user, inputs, ... }:

{
  imports =
    (import ../../../modules/hardware) ++
    (import ../../../modules/virtualisation) ++
    [
      ../hardware-configuration.nix
      ../../../modules/fonts
    ] ++ [
      # ../../../modules/desktop/bspwm
      ../../../modules/desktop/xmonad
    ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
  users.users.${user} = {
    initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = (with pkgs; [
      tdesktop
      qq
      feishu
      thunderbird
      blender
      dbeaver
      aichat
    ]) ++ (with config.nur.repos;[
      linyinfeng.icalingua-plus-plus
      linyinfeng.wemeet
    ]);
  };
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-table-extra fcitx5-pinyin-moegirl fcitx5-pinyin-zhwiki ];
  };

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager/system-connections"
        "/etc/v2raya"
        "/var/log"
        "/var/lib"
      ];
      users.${user} = {
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
          ".thunderbird"
          ".go-musicfox"
          "Flakes"
          "Kvm"
          ".cabal"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          ".local"
          ".mozilla"
        ];
        files = [
          ".npmrc"
        ];
      };
    };
    systemPackages = with pkgs; [
      libnotify
      xclip
      xorg.xrandr
      cinnamon.nemo
      networkmanagerapplet
      xorg.xev
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      pkgs.rust-bin.stable.latest.default
      lxappearance
      imagemagick
      flameshot
    ];
  };

  services.xserver = {
    xkbOptions = "caps:escape";
  };
  console.useXkbConfig = true;

  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services = {
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

}
