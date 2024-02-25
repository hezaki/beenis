{
  inputs = {
    # репозиторий nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # репозиторий home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # удивишься, это репозиторий hyprland...
    hyprland = {
      url = "github:hyprwm/Hyprland/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, ... } @ inputs: let
    inherit (self) outputs;
  in {
    # хост
    # ребилд: nixos-rebuild switch /etc/nixos/.#hostname
    nixosConfigurations = {
      # username и hostname можешь как угодно менять
      hostname = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = "x86_64-linux";
        modules = [
          ./host
        ];
      };
    };
    
    # юзер (разделять не обязательно, можешь убрать, это сделано для того, чтобы ребилдить по отдельности, а не фулл систему, пиздец)
    # ребилд: home-manager switch --flake /etc/nixos/.#username
    homeConfigurations = {
      username = home-manager.lib.homeManagerConfiguration { 
        pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
	        ./home
        ];
      };
    };
  };
}

