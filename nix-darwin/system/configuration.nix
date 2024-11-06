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
      glow
      fx
      lazydocker
      neovim # goto home-manager config
      obsidian
      openssh
      redis
      nodejs
      ollama
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
        persistent-apps = [
          "${pkgs.kitty}/Applications/kitty.app"
          "/Applications/Firefox.app"
          "/Applications/Google Chrome.app"
          "/Applications/Notion.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/Applications/Telegram.app"
          "/System/Applications/Mail.app"
        ];
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

  system.activationScripts = {
    applications.text = let
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
  };
  
  # home-manager.backupFileExtension = "backup";
  
  services = {
    nix-daemon = {
      enable = true;
    };
    jankyborders = {
      enable = true;
      package = pkgs.jankyborders;
      width = 8.0;
      style = "round";
      active_color = "gradient(top_left=0xffffc640,bottom_right=0xffba3aa5)";
      inactive_color = "gradient(top_left=0xaa45c4c0,bottom_right=0xaaba3aa5)";
      hidpi = true;
      ax_focus = true;
    };
    sketchybar = {
      enable = true;
      package = pkgs.sketchybar;
    };
  };

  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };

  programs.zsh.enable = true;
}
