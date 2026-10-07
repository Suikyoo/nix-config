{ inputs, lib, config, pkgs, ... }: {

  programs.foot.enable = true;

  
  home.packages = with pkgs; [
    brightnessctl
  ];


  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock.enable = true;
  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/Screenshots";
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
    };
  };

  stylix = {
    enable = true;
    image = ./imgs/arch-peak;
    polarity = "dark";

    fonts.monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.whitesur-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    targets.neovim.enable = false;
  };
  # lib.mapAttrs (k: v: k) (builtins.readDir ./imgs/);
  # specialisation = let {
  #  imgs = 
  #  }
  #  in map (i: ) imgs

# programs.localsend.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    package = null;
    portalPackage = null;

    settings = {

      "$bar" = "waybar";
      "$launcher" = "rofi";
      "$launch" = "rofi -show drun";
      "$editor" = "nvim";
      "$term" = "foot";
      "$screenshot" = "hyprshot";
      # "$devicesend" = "localsend";
      "$wallswitcher" = "wallswitch";
      "$toggleaspect" = "toggleaspect";

      "$super" = "SUPER";

      source = [ "${./config/hypr}/kanagawa.conf" ];

    };

    extraConfig = builtins.readFile ./config/hypr/hyprland.conf;

  };

  
}
