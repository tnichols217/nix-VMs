{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = github:tnichols217/home-manager/forceFlakes;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zlong_alert = {
      url = "github:kevinywlui/zlong_alert.zsh";
      flake = false;
    };

    p10k = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };

    # kitty themes
    kitty-themes = {
      url = "github:dexpota/kitty-themes";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, ... }@inputs: let 
    pre-mods = [
      inputs.home-manager.nixosModules.default
    ];
    mods = pre-mods ++ [
      ./configuration.nix
    ];
    version = "24.05";
    config = {
      allowUnfree = true;
    };
    outs = inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      fullAttrs = {
        inherit inputs version;
        nix-index-database = inputs.nix-index-database.packages.${system};
      };
    in rec {
      nixosConfigurations =
      let
        configs = {p, sys}:
        let
          fullAttrsPkgs = fullAttrs // { pkgs = p; };
        in {
          VM = inputs.nixpkgs.lib.nixosSystem {
            system = sys;
            specialArgs = fullAttrsPkgs;
            modules = mods;
          };
        };
      in (configs { p = (import inputs.nixpkgs { inherit system config;}); sys = system; }) //
      { cross = (inputs.flake-utils.lib.eachDefaultSystem (sys:
          (configs { p = (import inputs.nixpkgs { inherit config; localSystem = system; crossSystem = sys; }); inherit sys;})
        ));
      };
      apps = rec {
      };
    });
  in
  outs // {
    nixosConfigurations = outs.nixosConfigurations // outs.nixosConfigurations."x86_64-linux";
  };
}