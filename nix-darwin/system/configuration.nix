{ pkgs, config, inputs, ... }: {
  imports = [
    ../shared/brew.nix
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    configureBuildUsers = true;
  };

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [ 
      atac
      aichat
      age
      mkalias
      direnv
      glow
      fx
      lazydocker
      neovim
      obsidian
      openssh
      redis
      nodejs
    ];
  };

  nixpkgs = {
    config = {
      # Allow to install unfree apps as like Obsidian
      allowUnfree = true;
    };
    hostPlatform = "aarch64-darwin";
  };

  system = {
    stateVersion = 5;

    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleWindowTabbingMode = "fullscreen";
        NSWindowShouldDragOnGesture = true;
      };
      dock = {
        autohide = true;
        tilesize = 54;
        magnification = true;
        largesize = 75;
        mru-spaces = false;
        show-process-indicators = true;
        enable-spring-load-actions-on-all-items = true;
        mouse-over-hilite-stack = true;
      };
      WindowManager = {
        # GloballyEnabled = true;
        # AutoHide = true;
        EnableStandardClickToShowDesktop = false;
        StandardHideDesktopIcons = true;
        StandardHideWidgets = true;
        # StageManagerHideWidgets = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
        _FXSortFoldersFirst = true;
        ShowPathbar = true;
      };
      magicmouse = {
        MouseButtonMode = "OneButton";
      };
      trackpad = {
        TrackpadThreeFingerDrag = true;
      };
      menuExtraClock = {
        Show24Hour = true;
      };
      loginwindow = {
        LoginwindowText = "qmpwwsd <code>";
      };
      screencapture = {
        location = "~/Pictures/screenshots";
      };
      screensaver = {
        askForPasswordDelay = 10;
      };
    };
  };

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';
  
  # home-manager.backupFileExtension = "backup";
  
  services = {
    nix-daemon = {
      enable = true;
    };
  };

  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };

  programs.zsh.enable = true;
}