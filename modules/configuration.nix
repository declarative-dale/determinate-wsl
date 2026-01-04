# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [
    # NixOS-WSL module is now imported in flake.nix
  ];

  environment.systemPackages = with pkgs; [
    claude-code
    vim
    neovim
    micro
    xclip
    nil
    nixd
    nixfmt
    tmux
    bottom
    curl
    direnv
    pinentry-curses
    gpg-tui
    wget
    rsync
    restic
    tree
    unrar
    p7zip
    git
    openssl
    microfetch
  ];

  wsl.enable = true;
  wsl.defaultUser = username;

  # Enable nix-ld for VSCode/VSCodium Remote-WSL
  programs.nix-ld.enable = true;
  nix-ld-config.enable = true;
  nix-ld-config.user = username;

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Enable zsh system-wide (required for setting it as default shell)
  programs.zsh.enable = true;

  # Set zsh as default shell for user
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
