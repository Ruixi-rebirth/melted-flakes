**简体中文（中国大陆）** | [English (UK)](README_en.md)
<p align="center"><img src="https://user-images.githubusercontent.com/75824585/196194900-101f9d6e-cd97-4d80-ab50-2ac7b5a4f084.png" height=80px></p>
<h2 align="center">Ruixi-rebirth's NixOS Config</h2>
<p align="center"><img src="https://user-images.githubusercontent.com/75824585/196195007-ecebb290-2c6b-4fab-9e1e-2dbb12f7eb44.png" width=300px></p>

![](./screenshot/screenshot.png)

## 目录结构
```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── default.nix
│   ├── laptop
│   └── system.nix
├── modules
│   ├── desktop
│   ├── dev_lang
│   ├── editors
│   ├── environment
│   ├── fonts
│   ├── hardware
│   ├── programs
│   ├── scripts
│   ├── shell
│   ├── theme
│   └── virtualisation
├── overlays
│   ├── catppuccin-cursors.nix
│   └── catppuccin-gtk.nix
└── README.md
```

## 如何安装?
0. 分区和格式化分区自己完成
1. nixos-generate-config --root /mnt 
2.
```bash
$ git clone  https://github.com/Ruixi-rebirth/nixos-config.git /mnt/etc/nixos/ 

$ cd /mnt/etc/nixos/nixos-config && rm -rf .git 

$ cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos-config/hosts/laptop/hardware-configuration.nix

$ nixos-install --flake .#laptop
```
