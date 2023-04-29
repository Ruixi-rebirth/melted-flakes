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
          mission-control.scripts = {
            install = {
              description = "Install NixOS";
              exec = "nixos-install --flake .#laptop";
              category = "Tools";
            };
            update = {
              description = "Update flake inputs what you want,Please check ./flake-update.sh";
              exec = "sh ./flake-update.sh";
              category = "Tools";
            };
            rebuild = {
              description = "Switch to new profile";
              exec = "doas nixos-rebuild switch --flake .#laptop";
              category = "Tools";
            };
            fmt = {
              description = "Format the top-level Nix files(nixpkgs-fmt)";
              exec = "${lib.getExe pkgs.nixpkgs-fmt} ./*.nix";
              category = "Tools";
            };
            blog = {
              description = "Debug my blog";
              exec = ''
                cd "$FLAKE_ROOT/blog"
                cp -r ./static/hugo-theme-stack ./themes/
                ${lib.getExe pkgs.hugo} server --buildDrafts --forceSyncStatic'';
              category = "Tools";
            };
            disko = {
              description = "Pre-install,automatically partition and moount ";
              exec = "nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode zap_create_mount /path/to/disko-config.nix";
              category = "Tools";
            };
          };

          devShells = {
            #run by `nix devlop` or `nix-shell`(legacy)
            # default = import ./shell.nix { inherit pkgs; };
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [ git neovim colmena ];
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
      emacs-overlay.url = "github:nix-community/emacs-overlay";
      # lanzaboote = {
      #   url = "github:nix-community/lanzaboote";
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   inputs.rust-overlay.follows = "rust-overlay";
      # };
      disko.url = "github:nix-community/disko";
      colmena = {
        url = "github:zhaofengli/colmena";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

}
