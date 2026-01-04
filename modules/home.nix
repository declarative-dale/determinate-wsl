{ config, pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  # User packages
  home.packages = with pkgs; [
    zsh
    eza
    bat
    microfetch
  ];

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  # Oh My Posh configuration
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    useTheme = "night-owl";
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # fzf - fuzzy finder
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # zoxide - smarter cd command
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # bat - cat with syntax highlighting
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };

  # SSH configuration
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # Generate ed25519 SSH key on first activation (idempotent)
  home.activation.generateSshKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f ~/.ssh/id_ed25519 ]; then
      $DRY_RUN_CMD mkdir -p ~/.ssh
      $DRY_RUN_CMD chmod 700 ~/.ssh
      $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "${username}@nixos"
      echo "Generated new SSH ed25519 key at ~/.ssh/id_ed25519"
    fi
  '';
}
