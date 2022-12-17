#Qemu/KVM with virt-manager
{ config, pkgs, user, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      virt-manager
    ];
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      # onBoot = "ignore";
    };
  };
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  programs.dconf.enable = true;
  users.groups.libvirtd.members = [ "${user}" ];
}
