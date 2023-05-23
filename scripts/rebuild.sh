set -e

while true; do
    echo "Which device do you want to rebuild?"
    echo "1. laptop"
    echo "2. laptop_minimal"
    read -p  $'\e[1;32mEnter your choice(number): \e[0m' -r device

    case $device in
        1)
            doas nixos-rebuild switch --flake .#laptop;
            break ;;
        2)
            doas nixos-rebuild switch --flake .#laptop-minimal;
            break ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
