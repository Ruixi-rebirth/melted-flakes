{
  description = "My Personal NixOS Configuration";

  nixConfig = { };

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
            programs.beautysh = {
              enable = true;
              indent_size = 4;
            };
          };
          mission-control.scripts = {
            Install = {
              description = "After partitioning, formal installation of nixos";
              exec = "sh ./scripts/install.sh";
              category = "Tools";
            };
            update = {
              description = "Update flake inputs what you want,Please check ./scripts/flake-update.sh";
              exec = "sh ./scripts/flake-update.sh";
              category = "Tools";
            };
            rebuild = {
              description = "Switch to new profile";
              exec = "sh ./scripts/rebuild.sh";
              category = "Tools";
            };
            deploy = {
              description = "Remote deployment or local deployment";
              exec = "sh ./scripts/deploy.sh";
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
                git submodule update --init --recursive
                cd "$FLAKE_ROOT"/blog
                git checkout master
                emanote -L ./.
              '';
              category = "Tools";
            };
            disko = {
              description = "Pre-install,automatically partition and mount";
              exec = "sh ./scripts/disko.sh";
              category = "Tools";
            };
          };

          devShells = {
            #run by `nix devlop` or `nix-shell`(legacy)
            #Temporarily enable experimental features, run by`nix develop --extra-experimental-features nix-command --extra-experimental-features flakes`
            # default = import ./shell.nix { inherit pkgs; };
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                git
                neovim
                sbctl
              ];
              inputsFrom = [
                config.flake-root.devShell
                config.mission-control.devShell
              ];
            };
            #run by `nix develop .#<name>`
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
      nil.url = "github:oxalica/nil";
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
        #please read this doc -> https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md 
        url = "github:nix-community/lanzaboote";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.rust-overlay.follows = "rust-overlay";
      };
      disko.url = "github:nix-community/disko";
      emanote.url = "github:srid/emanote";
      joshuto.url = "github:Ruixi-rebirth/joshuto";
    };

}
