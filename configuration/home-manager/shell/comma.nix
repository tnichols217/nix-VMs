{ pkgs, version, lib, nix-index-database, ... }:
{
  programs.command-not-found.enable = pkgs.lib.mkForce false;

  home-manager.users.user = {
    home = {
      packages = with pkgs; [
          nix-index-database.comma-with-db
      ];
    };
    programs = {
      nix-index = {
        enable = true;
        package = nix-index-database.nix-index-with-db;
      };

      command-not-found.enable = false;
    };
  };
}
