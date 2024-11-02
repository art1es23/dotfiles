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

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };

    brews = [ 
      "mas"
      "imagemagick"
    ];

    casks = [
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
      "figma"
      "utm" # VM on macOS
      # "ngrock"
      # "zed"
      # "insomnia" # HTTP requests like Postman
      
      # Browsers
      "firefox"
      "google-chrome"

      # Productivity
      # "nikitabobko/tap/aerospace"
      "obsidian"
      "notion"
      "raycast"
      "deepl"

      # utilities
      "aldente" # battery management
      "appcleaner"
      "shottr"
      "keka"
      "cursorcerer"
      "transmission"
      "plover"

      # Additional
      "spotify"
      "binance"
      "meetingbar" # shows upcoming meetings
      "eul" # mac monitoring
      "wireshark" # network sniffer
      "keycastr" # show keystrokes on screen
      # "obs"
    ];

    taps = [
      # default
      "homebrew/bundle"
    ];
  };
}
