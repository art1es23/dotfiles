{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "dreamwinamounts@gmail.com";
    userName = "qmpwwsd";
    extraConfig = {
      init.defaultBranch = "master";
      core = {
        editor = "nvim";
        # autocrlf = "input";
      };
      # commit.gpgsign = true;
      # pull.rebase = true;
      # rebase.autoStash = true;
    };
  };
}
