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
}
