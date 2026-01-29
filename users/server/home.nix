{
  pkgs,
  inputs,
  config,
  ...
}: {
  clover = {
    programs = {
      #git = {
	#enable = true;
      #};
      zsh = {
        enable = true;
      };
    };
    services.vaultwarden.enable = true;

  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "24.05";
}

