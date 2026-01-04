{ config, pkgs, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.05";

  # User packages
  home.packages = with pkgs; [
    zsh
    oh-my-posh
    eza
  ];

  # Allow home-manager to manage itself
  programs.home-manager.enable = true;

  # Bash configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(oh-my-posh init bash --config $(oh-my-posh config list | grep night-owl | head -n 1))"
    '';
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      eval "$(oh-my-posh init zsh --config $(oh-my-posh config list | grep night-owl | head -n 1))"
    '';
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
}
