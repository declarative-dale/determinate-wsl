{
  pkgs,
  vars,
  agenix,
  ...
}:

{
  home = {
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "25.05";

    # User packages
    packages =
      with pkgs;
      [
        eza
        microfetch
      ]
      ++ [ agenix ];
  };

  programs = {
    # Allow home-manager to manage itself
    home-manager.enable = true;

    # Shell prompt
    oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      useTheme = "night-owl";
    };

    # Shells
    bash.enable = true;
    bash.enableCompletion = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    # CLI tools with shell integration
    fzf.enable = true;
    fzf.enableBashIntegration = true;
    fzf.enableZshIntegration = true;

    zoxide.enable = true;
    zoxide.enableBashIntegration = true;
    zoxide.enableZshIntegration = true;

    bat.enable = true;
    bat.config.theme = "TwoDark";
  };

  # Micro editor with WSL clipboard integration
  xdg.configFile."micro/settings.json".text = builtins.toJSON {
    clipboard = "external";
    clipboardcmd = "wslclip";
  };
}
