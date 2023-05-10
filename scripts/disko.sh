set -e

common_dir="$FLAKE_ROOT/hosts/laptop/disko_layout"

function ask {
    while true; do
        echo -n "Would you like to edit this layout? (y/n): "
        read choice
        if [ "$choice" = "y" ]; then
            nvim $partition_layout
            break
        elif [ "$choice" = "n" ]; then
            break
        else
            echo "Invalid input, please try again."
        fi
    done
}
# Select the disk partition layout and edit it
while true; do
    echo "Please select a disk partition layout:"
    echo "1. single-device"
    echo "2. single-device-luks"
    echo "3. multi-device"
    echo "4. multi-device-luks"
    read -p $'\e[1;32mEnter your choice(number): \e[0m' choice

    case $choice in
        1)
            partition_layout="$common_dir/single-device.nix";
            ask;
            break ;;
        2)
            partition_layout="$common_dir/single-device-luks.nix";
            ask;
            #to set luks password
            read -p $'\e[1;31mEnter LUKS password (important!): \e[0m' -r luks_pass
            echo -n "$luks_pass" > /tmp/secret.key

            break ;;
        3)
            partition_layout="$common_dir/multi-device.nix";
            ask;
            break ;;
        4)
            partition_layout="$common_dir/multi-device-luks.nix";
            ask;
            #to set luks password
            read -p $'\e[1;31mEnter LUKS password (important!): \e[0m' -r luks_pass
            echo -n "$luks_pass" > /tmp/secret.key
            break ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done

nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode zap_create_mount "$partition_layout"

mkdir -p /mnt/etc/nixos
mkdir -p /mnt/nix/persist/etc/nixos
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
nixos-generate-config --no-filesystems --root /mnt
cd /mnt/etc/nixos
cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/laptop/hardware-configuration.nix && cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/laptop_minimal/hardware-configuration.nix
# To truncate characters, simplify the following sed command
layout=.${partition_layout#$FLAKE_ROOT/hosts/laptop}
sed -i "/imports\ =/cimports\ = [(import\ $layout\ {})]++" "$FLAKE_ROOT"/hosts/{laptop,laptop_minimal}/hardware-configuration.nix
cp -r "$FLAKE_ROOT" /mnt/etc/nixos
lsblk
