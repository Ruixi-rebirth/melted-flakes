**简体中文（中国大陆）** | [English (UK)](README_en.md)

[![Push Blog](https://github.com/ruixi-rebirth/nixos-config/actions/workflows/push_blog.yml/badge.svg)](https://ruixi-rebirth.github.io) [![NixOS](https://github.com/ruixi-rebirth/nixos-config/actions/workflows/NixOS.yml/badge.svg)](https://github.com/Ruixi-rebirth/nixos-config/actions/workflows/NixOS.yml)

<p align="center"><img src="https://user-images.githubusercontent.com/75824585/210402874-da3422d5-ab65-4975-b73a-c300065c6792.png" width=300px></p>
<h2 align="center">Ruixi-rebirth's NixOS Config</h2>
<p align="center"><img src="https://user-images.githubusercontent.com/75824585/196195007-ecebb290-2c6b-4fab-9e1e-2dbb12f7eb44.png" width=300px></p>

https://user-images.githubusercontent.com/75824585/201473117-578af0df-e4ea-4dc9-91a6-c30281d46e7a.mp4

### 系统组件
||NixOS(Wayland)|
| - | :--: |
|**Window Manager**|[Sway](https://github.com/swaywm/sway), [Hyprland](https://github.com/hyprwm/Hyprland)|
|**Terminal Emulator**|[Kitty](https://github.com/kovidgoyal/kitty)|
|**Bar**|[Waybar](https://github.com/Alexays/Waybar)|
|**Application Launcher**|[Rofi-wayland](https://github.com/lbonn/rofi)|
|**Notification Daemon**|[Mako](https://github.com/emersion/mako)|
|**Display Manager**|None(TTY1 Login)|
|**network management tool**|[NetworkManager](https://networkmanager.dev/)|
|**Input method framework**|[Fcitx5](https://github.com/fcitx/fcitx5)|
|**System resource monitor**|[Btop](https://github.com/aristocratos/btop)|
|**File Manager**|[Ranger](https://github.com/ranger/ranger), [Nemo](https://github.com/linuxmint/nemo)|
|**Lockscreen**|[Swaylock-effects](https://github.com/mortie/swaylock-effects)|
|**Shell**|[Fish](https://github.com/fish-shell/fish-shell)|
|**Music Player**|[mpd](https://github.com/MusicPlayerDaemon/MPD), [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp), [mpc](https://github.com/MusicPlayerDaemon/mpc), [Netease-cloud-music-gtk](https://github.com/gmg137/netease-cloud-music-gtk)|
|**Media Player**|[mpv](https://github.com/mpv-player/mpv)|
|**Text Editor**|[Neovim](https://github.com/neovim/neovim)|
|**Icons**|[Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)|
|**Fonts**|[Nerd fonts](https://github.com/ryanoasis/nerd-fonts)|
|**Image Viewer**|[imv](https://sr.ht/~exec64/imv/)|
|**Screenshot Software**|[grimshot](https://github.com/swaywm/sway/blob/master/contrib/grimshot),[grimblast](https://github.com/hyprwm/contrib)|
|**Screen Recording**|[wf-recorder](https://github.com/ammen99/wf-recorder), [OBS](https://obsproject.com)|
|**Clipboard**|[wl-clipboard](https://github.com/bugaevc/wl-clipboard)|
|**Color Picker**|[hyprpicker](https://github.com/hyprwm/hyprpicker)|

### 主题
**catppuccin-light**
![2023-01-12T02:21:59](https://user-images.githubusercontent.com/75824585/211895195-e0a47165-e635-4256-922c-17d7da1ed62e.png)

**catppuccin-dark**
![2023-01-12T03:00:29](https://user-images.githubusercontent.com/75824585/211895280-41d12bfe-453c-41da-a2a6-3f7f483ea8ad.png)

**nord**
![2023-01-17T00:15:22](https://user-images.githubusercontent.com/75824585/212723937-c56200da-52f4-407b-9d8e-428348ed5ed0.png)


*安装主题任意选择一个即可：具体见[这里](https://github.com/Ruixi-rebirth/nixos-config/blob/main/hosts/laptop/home.nix#L11-L13)*

### 屏幕截图
<details>
<summary><b>Click to expend</b></summary>

![](./screenshot/light.png)
![](./screenshot/dark.png)
![](./screenshot/nord.png)

</details>

### 目录结构
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
│   ├── devlop
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
│   └── default.nix
├── pkgs
│   ├── catppuccin-cursors
│   ├── catppuccin-gtk
│   └── default.nix
├── README_en.md
├── README.md
└── screenshot
    └── screenshot.png
```

### 如何安装?(root on tmpfs)
0. 假设我已经分好两个分区`/dev/nvme0n1p1` `/dev/nvme0n1p3`
1. 格式化分区
```bash
  mkfs.fat -F 32 /dev/nvme0n1p1 
  mkfs.ext4 /dev/nvme0n1p3
```
2. 挂载
```bash
  mount -t tmpfs none /mnt 
  mkdir -p /mnt/{boot,nix}
  mount /dev/nvme0n1p3 /mnt/nix
  mount /dev/nvme0n1p1 /mnt/boot 
```
3. 生成一个基本的配置 
```bash
  nixos-generate-config --root /mnt
```
4. 克隆仓库到本地
```bash
nix-shell -p git
git clone  https://github.com/Ruixi-rebirth/nixos-config.git /mnt/etc/nixos/Flakes 
```
5. 将 /mnt/etc/nixos 中的 `hardware-configuration.nix` 拷贝到 /mnt/etc/nixos/Flakes/hosts/laptop/hardware-configuration.nix
```bash 
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/Flakes/hosts/laptop/hardware-configuration.nix
```
6. 修改被覆盖后的 `hardware-configuration.nix`
```bash
nano /mnt/etc/nixos/Flakes/hosts/laptop/hardware-configuration.nix
```
```nix
...
#这只是一个例子
#请参考 `https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/#step-4-1-configure-disks`

fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b0f7587b-1eb4-43ad-b4a1-e6385b8511ae";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3C0D-7D32";
      fsType = "vfat";
    };
...
```
7. 进入克隆的仓库并移除 '/mnt/etc/nixos/Flakes/.git'
```bash 
cd /mnt/etc/nixos/Flakes && rm -rf .git
```
8. 修改用户 *root* 和 *ruixi* 的登陆密码,使用 `mkpasswd -m sha-512` 命令生成的hash密码将 `/mnt/etc/nixos/Flakes/hosts/laptop/default.nix` 中的 `users.users.<name>.hashedPassword` 的值替换掉
9. 安装
```bash
nixos-install --no-root-passwd --flake .#laptop

#或者指定源：
nixos-install --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" --no-root-passwd --flake .#laptop
```
10. 重启
```bash
reboot
```
11. 享受它吧！
