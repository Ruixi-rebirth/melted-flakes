{ config, pkgs, user, inputs, ... }:

{
  imports =
    (import ../../modules/hardware) ++
    (import ../../modules/virtualisation) ++
    (import ../../modules/theme/catppuccin-frappe-dark) ++
    [
      ./hardware-configuration.nix
      ../../modules/fonts
    ] ++ [
      # ../../modules/desktop/sway
      ../../modules/desktop/hyprland
    ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
  users.users.${user} = {
    initialHashedPassword = "$6$4lwj3AGq8M9CQE2.$q8cNPghWHTl/dfE0dMPm2vsh0cMpY2gWxw91/Uadi8jShbvUHJJu3Jg0CvSpqrlEB7a3kvWDf/p2CI3mSqP1c/";
    # shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = with pkgs; [
      tdesktop
      qq
      feishu
      pkgs.sway-contrib.grimshot
      imagemagick
      thunderbird
    ];
  };
  boot = {
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

  programs = {
    dconf.enable = true;
    light.enable = true;
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
          ".thunderbird"
          "Flakes"
          "Kvm"
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
      wl-clipboard
      wlr-randr
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
      cinnamon.nemo
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      ntfs3g
      pkgs.rust-bin.stable.latest.default
      blender
      lxappearance
    ];
  };

  services = {
    getty.autologinUser = "ruixi";
    gvfs.enable = true;
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

}
