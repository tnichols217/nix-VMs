{ pkgs, version, lib, nix-index-database, ... }@ args:
{
  imports = [
    ./shell/kitty.nix
    ./shell/comma.nix
    ./shell/zsh.nix
    ./shell/starship.nix
  ];

  users.users.user = {
    shell = pkgs.zsh;
  };

  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.user = {
    home = {
      packages = with pkgs; [
          bat
          lsd
          xclip
      ];
      shell = {
        enableShellIntegration = true;
        enableNushellIntegration = true;
        enableFishIntegration = false;
      };
    };
    programs = {
      git = {
        enable = true;
        userName = "tnichols217";
        userEmail = "62992267+tnichols217@users.noreply.github.com";
        diff-so-fancy = {
          enable = true;
        };
        lfs = {
          enable = true;
        };
        extraConfig = {
          credential = {
            helper = "store";
          };
          commit.gpgsign = true;
          gpg.format = "ssh";
          gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          user.signingkey = "~/.ssh/ed25519.pub";
        };
      };
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings.git_protocol = "ssh";
      };
      nushell = {
        enable = true;
      };
      fzf = {
        enable = true;
      };
      direnv = {
        enable = true;
        config = {
          global = {
            disable_stdin = true;
          };
        };
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
