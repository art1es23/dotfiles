{ config, pkgs, ... }:
{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ]; 
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    fd = {
      enable = true;
    };
    lazygit = {
      enable = true;
    };
    thefuck = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
    ssh = {
      enable = true;
    };
  };
}
