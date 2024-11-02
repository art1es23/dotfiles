{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    prefix = "C-Space";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      tmux-thumbs
      cpu
      weather
      vim-tmux-navigator
      better-mouse-mode
      sensible
      yank
      # tokyo-night-tmux
      {
        plugin = power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'moon'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          # set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          # set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
