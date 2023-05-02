flake_input=(
    colmena
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
    neovim-nightly-overlay
)
for item in "${flake_input[@]}"
do
    echo "$item:"
    nix flake lock --update-input "$item"
done
