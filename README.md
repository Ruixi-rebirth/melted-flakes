<p align="center"><img src="https://user-images.githubusercontent.com/75824585/196194900-101f9d6e-cd97-4d80-ab50-2ac7b5a4f084.png" height=80px></p>
<h2 align="center">Ruixi-rebirth's NixOS Config</h2>
<p align="center"><img src="https://user-images.githubusercontent.com/75824585/196195007-ecebb290-2c6b-4fab-9e1e-2dbb12f7eb44.png" width=300px></p>

![2022-10-17T22:05:06](https://user-images.githubusercontent.com/75824585/196198382-8df63882-f56e-4fb9-9add-7dc02fd4e317.png)

## How to build 
```bash
git clone  https://github.com/Ruixi-rebirth/nixos-config.git && cd nixos-config

sudo nixos-rebuild switch --flake .#laptop
```
待解决细节:

- GTK/QT 主题
- QT 托盘图标很原始
- mpv 播放视频黑屏，硬件加速，没有做好
- nvim 少数lsp有点问题

