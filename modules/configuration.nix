# System-wide NixOS configuration
# For user-specific configuration, see home.nix

{
  pkgs,
  vars,
  agenix,
  ...
}:

{
  # Import Nix development environment module
  imports = [ ./nix-dev ];

  # WSL Configuration
  wsl = {
    enable = true;
    defaultUser = vars.username;
    wslConf.network.hostname = vars.hostname;
  };

  # Nixpkgs Configuration
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages =
    with pkgs;
    [
      # Development tools
      claude-code
      git
      direnv

      # Editors
      vim
      neovim
      micro

      # Note: Nix development tools now provided by nix-dev module

      # CLI utilities
      tmux
      bottom
      curl
      wget
      rsync
      restic
      tree
      
      # WSL utilities
      wslu

      # Archive tools
      unrar
      p7zip

      # Security
      openssl

      # System info
      microfetch
    ]
    ++ [ agenix ];

  # Programs Configuration
  programs = {
    # VSCode/VSCodium Remote-WSL support
    nix-ld.dev.enable = true;

    # Zsh (required for user shell)
    zsh.enable = true;
  };

  # nix-ld configuration for VSCode/VSCodium
  nix-ld-config = {
    enable = true;
    user = vars.username;
  };

  # User Configuration
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
}
