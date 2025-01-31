{
  pkgs,
  inputs,
  config,
  ...
}: {
  clover = {
    services = {
      vaultwarden = {
        enable = true;  # This should work if the module is properly defined
      };
    };

    programs = {
      zsh = {
        enable = true;  # This works as you expect
      };
    };
  };

  home.packages = with pkgs; [
    firefox
  ];

  home.stateVersion = "24.05";
}

