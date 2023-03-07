{ fetchFromGitHub
, buildGoModule
, clangStdenv

}:

buildGoModule.override { stdenv = clangStdenv; } rec {
  pname = "bilibili-live-tui";
  version = "e908b31";
  src = fetchFromGitHub ({
    owner = "yaocccc";
    repo = "bilibili_live_tui";
    rev = "${version}";
    fetchSubmodules = false;
    sha256 = "sha256-U9Q5lUGL6QbhfVzF3zqUrAXUNmbcmh7CVZ3xFbYktvE=";
  });
  # deleteVendor = true;

  # vendorHash = null;

  vendorSha256 = "sha256-eTxfF8jj8NF7A83gYeKuMW7n7ooKJ/68VsejUGph/2s=";
}
