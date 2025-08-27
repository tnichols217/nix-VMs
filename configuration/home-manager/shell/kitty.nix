{ pkgs, version, lib, nix-index-database, ... }:
{
  home-manager.users.user = {
    programs = {
      kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = false;
        settings = {
          background_opacity = "0.5";
          background_blur = 5;
        };
        keybindings = {
          "ctrl+shift+t" = "new_tab_with_cwd !neighbor";
          "ctrl+shift+alt+t" = "new_tab !neighbor";
        };
      };
    };
  };
}
