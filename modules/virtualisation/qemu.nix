#Qemu/KVM with virt-manager
{ config, pkgs, user, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      virt-manager
      qemu
    ];
  };
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  users.groups.libvirtd.members = [ "${user}" ];
}
