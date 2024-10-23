{ nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
{
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
  ];

  # environment.systemPath = [ "/opt/homebrew/bin" ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    # autoMigrate = true;

    # TODO(clo4): make another user to own the homebrew prefix
    # because things get annoying when you add another user to
    # the machine that also wants to use brew.
    # This isn't a problem *yet*, but it's not a matter of 'if'
    # it will be, just when.
    user = "qmpwwsd";

    # All taps must be declared below.
    mutableTaps = false;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
  };

  homebrew.enable = true;
  homebrew.brews = [ "mas" "imagemagick" ];

  # Applications are installed through Homebrew because there's a wider selection available
  # on macOS and the applications tend to be more up-to-date.
  # The other reason is that applications installed via Nix tend to break in the dock because
  # of the way the volume mounts - it's been a while but from what I remember the icons weren't
  # working correctly, or maybe it's that opening them on startup was having problems?
  homebrew.casks = [
    # NOTE: Homerow isn't available as a cask yet

    "1password"
    "nordpass"

    # Loosely, social platforms
    "discord"
    "telegram"
    "microsoft-teams"
    # "steam"
    
    # Development
    "docker"
    "wezterm"
    "figma"
    "utm" # VM on macOS
    # "ngrock"
    # "zed"
    # "insomnia" # HTTP requests like Postman
    
    # Browsers
    "firefox"
    "google-chrome"

    # Productivity
    "obsidian"
    "notion"
    "raycast"
    "deepl"

    # Additional
    "appcleaner"
    "shottr"
    "keka"
    "cursorcerer"
    "plover"
    "spotify"
    "transmission"
    "binance"
    # "karabiner-elements" # Might make a module for this in the future...
    # "iina"
    # "obs"
    # "font-meslo-lg-nerd-font"
  ];

  homebrew.onActivation = {
    cleanup = "zap";
    upgrade = true;
    autoUpdate = true;
  };
}
