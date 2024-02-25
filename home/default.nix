{ pkgs, inputs, ... }: {
  home = {
    username = "название юзера";
    homeDirectory = "/home/название юзера";
    stateVersion = "23.11";
    packages = with pkgs; [
      # pkg list !
      neofetch
	  ];
	};
	programs.home-manager.enable = true;
	nixpkgs.config.allowUnfree = true;
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    enableNvidiaPatches = false;
    systemd.enable = false;
  };
}
