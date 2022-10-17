{ config, pkgs, ... }:

{
   programs = {
     mako = {
       enable = true;
       font = "Iosevka Nerd Font 12";
       backgroundColor = "#1E1D2F";
       borderColor = "#96CDFB";
       progressColor="over #302D41";
       textColor = "#D9E0EE";
       extraConfig = ''
         [urgency=high]
         border-color=#F8BD96
       '';
     };
   };
}
