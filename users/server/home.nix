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
  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "24.05";
}

