function trap_ctrlc {
    echo "Ctrl-C caught...exiting."
    exit 1
}
trap "trap_ctrlc" 2

flake_input=(
    disko
    emacs-overlay
    flake-parts
    flake-root
    home-manager
    hypr-contrib
    hyprland
    hyprpicker
    impermanence
    mission-control
    nixpkgs
    nur
    picom
    sops-nix
    lanzaboote
    rust-overlay
    nil
    neovim-nightly-overlay
    treefmt-nix
    emanote
    joshuto
)
for item in "${flake_input[@]}"
do
    echo -e "\033[1;34m${item}: \033[0m"
    nix flake lock --update-input "$item"
done
