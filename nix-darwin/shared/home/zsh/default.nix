{ config, pkgs, ... }:
{ 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "git-commit"
        "web-search"
        "brew"
        "docker"
        "npm"
        "history"
        "node"
        "rust"
        "deno"
        "bun"
        "eza"
        "vi-mode"
        "heroku"
        "ssh"
        "ssh-agent"
        "tmux"
        "nvm"
        "thefuck"
        "fzf"
        "zoxide"
        "redis-cli"
      ];
    };

    # plugins = [
    #   {
    #     name = "zsh-nix-shell";
    #     file = "nix-shell.plugin.zsh";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "chisui";
    #       repo = "zsh-nix-shell";
    #       rev = "v0.8.0";
    #       sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
    #     };
    #   }
    # ];

    initExtra = builtins.readFile ./.zshrc;

    shellAliases = {
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      ll = "ls -l";
      fk = "thefuck";
      darwin-build-flake = "nix build .#darwinConfigurations.qmpwwsd.system --impure";
      darwin-update-flake = "darwin-rebuild switch --dry-run --impure --flake .#qmpwwsd";
      home-update = "home-manager switch --flake .#qmpwwsd@qmpwwsd --impure";
    };
  };
}
