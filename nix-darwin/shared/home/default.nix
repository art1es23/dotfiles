{ config, pkgs, ... }:
{
  programs = {
    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    fd = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    lazygit = {
      enable = true;
    };
    ripgrep = {
      enable = true;
    };
    ssh = {
      enable = true;
    };
    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ]; 
    };
  };
}
