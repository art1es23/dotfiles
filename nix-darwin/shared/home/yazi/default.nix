{
  inputs,
  pkgs,
  config,
  ...
}:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    # package = inputs.yazi.packages.${pkgs.system}.default;
  };
}
