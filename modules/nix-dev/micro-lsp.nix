# Micro editor LSP configuration for Nix development
# Automatically installs and configures the LSP plugin with nil
{ pkgs, ... }:

let
  # Fetch the micro LSP plugin from GitHub
  microLspPlugin = pkgs.fetchFromGitHub {
    owner = "AndCake";
    repo = "micro-plugin-lsp";
    rev = "v1.0.11";
    sha256 = "sha256-RuXNSHaas/L6SjlGH1fUrbYPJd7yw+llEUwq85PPEqo=";
  };

  # LSP configuration for various file types
  lspConfig = {
    # Nix language server configuration
    "*.nix" = {
      command = "nil";
      args = [ ];
    };

    # You can add more language servers here
    # "*.py" = {
    #   command = "pyright-langserver";
    #   args = ["--stdio"];
    # };
  };

  # Micro settings with LSP enabled
  microSettings = {
    autosu = true;
    colorscheme = "monokai";
    mkparents = true;
    savecursor = true;
    saveundo = true;
    scrollbar = true;
    tabsize = 2;
    tabstospaces = true;
    clipboard = "external";
    clipboardcmd = "wslclip";

    # LSP-specific settings
    lsp = true;
    lsp-autocomplete = true;
    lsp-signature-help = true;
    lsp-hover = true;
    lsp-diagnostics = true;
  };

in
{
  # Install the LSP plugin
  xdg.configFile."micro/plug/lsp" = {
    source = microLspPlugin;
    recursive = true;
  };

  # Configure LSP servers
  xdg.configFile."micro/lsp-config.json".text = builtins.toJSON lspConfig;

  # Update micro settings to enable LSP features
  programs.micro.settings = microSettings;

  # Add keybindings for LSP features
  xdg.configFile."micro/bindings.json".text = builtins.toJSON {
    # Comment toggling
    "Alt-/" = "lua:comment.comment";
    "CtrlUnderscore" = "lua:comment.comment";

    # LSP keybindings
    "Alt-k" = "command:lsp-hover";           # Show hover information
    "Alt-d" = "command:lsp-definition";      # Go to definition
    "Alt-r" = "command:lsp-references";      # Find references
    "Alt-f" = "command:lsp-format";          # Format document
    "Alt-a" = "command:lsp-code-action";     # Code actions
    "Alt-n" = "command:lsp-next-diagnostic"; # Next diagnostic
    "Alt-p" = "command:lsp-prev-diagnostic"; # Previous diagnostic
  };
}
