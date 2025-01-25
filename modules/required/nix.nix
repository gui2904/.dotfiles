{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      trusted-users = ["@wheel" "root"];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
