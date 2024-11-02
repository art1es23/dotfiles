# home.nix
# home-manager switch

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  home-manager,
  ...
}:

{
  imports = [
    ../shared/home
    ../shared/home/alacritty.nix
    ../shared/home/git.nix
    ../shared/home/kitty
    ../shared/home/starship.nix
    ../shared/home/tmux
    ../shared/home/wezterm
    ../shared/home/yazi
    ../shared/home/zsh
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-storm;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
      stateVersion = "24.05";
      username = "qmpwwsd";
      homeDirectory = "/Users/qmpwwsd";
      packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "FiraCode"]; })
      ];
      sessionVariables = {
        EDITOR = "nvim";
        SHELL = "zsh";
        TERMINAL = "kitty";
      };
      file = {
        ".config/nvim".source = ~/dotfiles/nvim;
        ".config/nix".source = ~/dotfiles/nix;
      };
      sessionPath = [
        "/run/current-system/sw/bin"
          "$HOME/.nix-profile/bin"
      ];
  };
}
