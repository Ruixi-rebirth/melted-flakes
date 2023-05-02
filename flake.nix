{
  description = "My Personal NixOS Configuration";

  outputs = inputs @ { self, nixpkgs, flake-parts, ... }:
    let
      user = "ruixi";
      domain = "ruixi2fp.top";
      selfPkgs = import ./pkgs;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        inputs.flake-root.flakeModule
        inputs.mission-control.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      perSystem = { config, inputs', pkgs, system, lib, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        {
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            package = pkgs.treefmt;
            programs.nixpkgs-fmt.enable = true;
          };
          mission-control.scripts = {
            install = {
              description = "Install NixOS";
              #TODO: Currently only available for my laptop, will be more flexible for other devices 
              exec = ''
                set -e
                echo "set your user login password"
                #to set user login password
                passwd_hash=$(mkpasswd -m sha-512  2>/dev/null)
                cd /mnt/etc/nixos/Flakes 
                sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$passwd_hash\";" ./hosts/laptop/{wayland,x11}/default.nix && sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$passwd_hash\";" ./hosts/laptop_minimal/default.nix

                read -p  "device name: " -r device
                nixos-install --no-root-passwd --flake .#"$device"
              '';
              category = "Tools";
            };
            update = {
              description = "Update flake inputs what you want,Please check ./flake-update.sh";
              exec = "sh ./flake-update.sh";
              category = "Tools";
            };
            rebuild = {
              description = "Switch to new profile";
              exec = ''
                read -p  "device name: " -r device
                doas nixos-rebuild switch --flake .#"$device"'';
              category = "Tools";
            };
            deploy = {
              description = "Remote deployment or local deployment";
              exec = "sh deploy.sh";
              category = "Tools";
            };
            fmt = {
              description = "Format the source tree";
              exec = config.treefmt.build.wrapper;
              category = "Tools";
            };
            blog = {
              description = "Debug my blog";
              exec = ''
                cd "$FLAKE_ROOT"/blog
                cp -r ./static/hugo-theme-stack ./themes/
                ${lib.getExe pkgs.hugo} server --buildDrafts --forceSyncStatic'';
              category = "Tools";
            };
            disko = {
              description = "Pre-install,automatically partition and moount ";
              #TODO: Currently only available for my laptop, will be more flexible for other devices 
              exec = ''
                set -e
                #to set luks password
                read -p  "luks password(important!): " -r luks_pass 
                echo -n "$luks_pass" > /tmp/secret.key
                nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode zap_create_mount "$FLAKE_ROOT"/hosts/laptop/disko_layout/multi-device-luks.nix
                mkdir -p /mnt/etc/nixos
                mkdir -p /mnt/nix/persist/etc/nixos
                mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
                nixos-generate-config --no-filesystems --root /mnt
                cd /mnt/etc/nixos 
                cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/laptop/hardware-configuration.nix && cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/laptop_minimal/hardware-configuration.nix 
                sed -i 's/imports\ =/imports\ = [(import\ .\/disko_layout\/multi-device-luks.nix\ {})]++/g' "$FLAKE_ROOT"/hosts/{laptop,laptop_minimal}/hardware-configuration.nix
                cp -r "$FLAKE_ROOT" /mnt/etc/nixos  
                lsblk
              '';
              category = "Tools";
            };
          };

          devShells = {
            #run by `nix devlop` or `nix-shell`(legacy)
            #Temporarily enable experimental features, run by`nix develop --extra-experimental-features nix-command --extra-experimental-features flakes`
            # default = import ./shell.nix { inherit pkgs; };
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [ git neovim colmena sbctl ];
              inputsFrom = [
                config.flake-root.devShell
                config.mission-control.devShell
              ];
            };
            #run ny `nix devShell .#<name>`
            secret = with pkgs; mkShell {
              name = "secret";
              nativeBuildInputs = [
                sops
                age
                ssh-to-age
                ssh-to-pgp
              ];
              shellHook = ''
                export PS1="\e[0;31m(Secret)\$ \e[m" 
              '';
            };
          };
        };

      flake = {
        overlays.default = selfPkgs.overlay;
        nixosConfigurations = (
          import ./hosts {
            system = "x86_64-linux";
            inherit nixpkgs self inputs user;
          }
        );
      };
    };

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
      rust-overlay.url = "github:oxalica/rust-overlay";
      impermanence.url = "github:nix-community/impermanence";
      nur.url = "github:nix-community/NUR";
      hyprpicker.url = "github:hyprwm/hyprpicker";
      hypr-contrib.url = "github:hyprwm/contrib";
      flake-parts.url = "github:hercules-ci/flake-parts";
      sops-nix.url = "github:Mic92/sops-nix";
      picom.url = "github:yaocccc/picom";
      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      flake-root.url = "github:srid/flake-root";
      mission-control.url = "github:Platonic-Systems/mission-control";
      treefmt-nix.url = "github:numtide/treefmt-nix";
      emacs-overlay.url = "github:nix-community/emacs-overlay";
      lanzaboote = {
        url = "github:nix-community/lanzaboote";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.rust-overlay.follows = "rust-overlay";
      };
      disko.url = "github:nix-community/disko";
      colmena = {
        url = "github:zhaofengli/colmena";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

}
