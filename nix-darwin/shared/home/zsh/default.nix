{ config, pkgs, ... }:
{ 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      # theme = "spaceship";
      plugins = [
        "asdf"
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

    initExtra = builtins.readFile ./.zshrc;

    shellAliases = {
      v = "nvim";
      home = "z ~";
      lss = "yazi";
      gc = "git commit";
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      ll = "ls -l";
      fk = "thefuck";
      darwin-build-flake = "nix build .#darwinConfigurations.qmpwwsd.system --impure";
      darwin-update-flake = "darwin-rebuild switch --dry-run --impure --flake .#qmpwwsd";
      home-update = "home-manager switch --flake .#qmpwwsd@qmpwwsd --impure";
      "." = "z ..";
      ".." = "z ../..";
      "..." = "z ../../..";
    };
  };
}
