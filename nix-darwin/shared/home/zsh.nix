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

    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # Add any additional configurations here
      export NIX_CONF_DIR=$HOME/.config/nix
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH

      # # ----- Bat (better cat) -----
      # export BAT_THEME=tokyonight_night
      # Vim mode
      set -o vi
      bindkey -v

      # -- Use fd instead of fzf --

      export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

      # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      # --- Setup fzf theme ---
      export FZF_DEFAULT_OPTS="--color=fg:#CBE0F0,bg:#011628,hl:#B388FF,fg+:#CBE0F0,bg+:#143652,hl+:#B388FF,info:#06BCE4,prompt:#2CF9ED,pointer:#2CF9ED,marker:#2CF9ED,spinner:#2CF9ED,header:#2CF9ED"

      show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

      export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

      # Advanced customization of fzf options via _fzf_comprun function
      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }

      # # source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';

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
