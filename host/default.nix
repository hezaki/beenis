{ pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix 
    # этот файл будет сгенерирован, пихни его в .
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/vda";
      useOSProber = true;
    };
  };

  networking = {
    hostName = названиехоста;
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
    dhcpcd = {
      wait = "background";
      extraConfig = "noarp";
    };
  };

  time.timeZone = "твоё";

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  users.users.имяюзера = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
	  home-manager
	  htop-vim
	  # pkgs list !
  ];

  system.stateVersion = "23.11"; 
}
