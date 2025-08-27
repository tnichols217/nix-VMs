{ version, ... }:
{
  imports = [
    ./home-manager/hyprland.nix
    ./home-manager/shell.nix
  ];

  home-manager.users.user = {
    home = {
      stateVersion = version;
      forceNixProfiles = true;
    };
  };
}