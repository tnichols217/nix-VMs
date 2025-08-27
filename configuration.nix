{ config, lib, pkgs, version, modulesPath, ... } :
{
  imports = [
    ./configuration/home-manager.nix
    ./configuration/VM.nix
    ./configuration/greetd.nix
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  time.timeZone = "Asia/Kuala_Lumpur";

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root = {
        hashedPassword = lib.mkForce "!";
        packages = with pkgs; [
        ];
      };

      user = {
        password = ''password'';
        isNormalUser = true;
        extraGroups = [ "wheel" "libvirtd" "networkmanager" "docker" "podman" "servarr" "input" "dialout" "uucp" "kvm" "seat" "video" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nano
    coreutils
    networkmanager
    kitty
  ];

  programs = {
    zsh.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      GatewayPorts = "yes";
    };
  };

  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };

    hostName = "VM";
    nftables.enable = true;
  };

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      builders-use-substitutes = true
    '';
    settings = {
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://cache.nixos.org/"
        "https://raspberry-pi-nix.cachix.org"
        "https://tnichols217-nixos-config.cachix.org"
      ];
      trusted-public-keys = [
        "tnichols217-nixos-config.cachix.org-1:B9JhBiPS+OHykLW16qovoOelAvtdH5sIjYU7BZvs7q8="
        "raspberry-pi-nix.cachix.org-1:WmV2rdSangxW0rZjY/tBvBDSaNFQ3DyEQsVw8EvHn9o="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      auto-optimise-store = true;
      trusted-users = [ "user" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ] ++ lib.lists.filter lib.isDerivation (builtins.attrValues nerd-fonts);
    enableDefaultPackages = true;
  };

  system.stateVersion = version;
}

