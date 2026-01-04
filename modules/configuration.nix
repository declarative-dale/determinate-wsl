# System-wide NixOS configuration
# For user-specific configuration, see home.nix

{ pkgs, username, ... }:

{
  # WSL Configuration
  wsl = {
    enable = true;
    defaultUser = username;
  };

  # Nixpkgs Configuration
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    # Development tools
    claude-code
    git
    direnv

    # Editors
    vim
    neovim
    micro

    # Nix tools
    nil
    nixd
    nixfmt

    # CLI utilities
    tmux
    bottom
    curl
    wget
    rsync
    restic
    tree
    wslu # WSL utilities including wslclip for clipboard integration

    # Archive tools
    unrar
    p7zip

    # Security
    openssl
    pinentry-curses
    gpg-tui

    # System info
    microfetch
  ];

  # Programs Configuration
  programs = {
    # VSCode/VSCodium Remote-WSL support
    nix-ld.dev.enable = true;

    # GPG agent with SSH support
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    # Zsh (required for user shell)
    zsh.enable = true;
  };

  # nix-ld configuration for VSCode/VSCodium
  nix-ld-config = {
    enable = true;
    user = username;
  };

  # User Configuration
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}
