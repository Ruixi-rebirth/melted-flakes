#!/usr/bin/env nix-shell
#!nix-shell -i bash -p wget  nix-prefetch-git jq
set -eu -o pipefail

owner="go-musicfox"
repo="go-musicfox"  
dirname="$(dirname "$0")"

version=$(curl --silent "https://api.github.com/repos/$owner/$repo/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')           
echo got version $version
echo \""${version#v}"\" > "$dirname/version.nix"

source_Sha256="$(nix-prefetch-git --quiet --rev ${version} https://github.com/$owner/$repo | jq .sha256)"
printf '%s\n' "$source_Sha256" > $dirname/source-sha.nix
tput setaf 4
echo got source-Sha256 of: $source_Sha256
tput sgr0

tput setaf 1
echo zeroing vendorSha256 in $dirname/vendor-sha.nix
tput sgr0
echo  \""0000000000000000000000000000000000000000000000000000"\" > $dirname/vendor-sha.nix
set +e
vendorSha256="$(nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }' 2>&1 | grep "got:" | cut -d':' -f2 | tr -d '[:space:]')"
set -e
echo \""$vendorSha256"\" > $dirname/vendor-sha.nix
tput setaf 2
echo got vendorSha256 of: $vendorSha256
tput sgr0

nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'

