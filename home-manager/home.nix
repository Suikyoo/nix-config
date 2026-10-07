# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./nvim.nix
    # ./hyprland.nix
    # ./csec.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      inputs.nix-firefox-addons.overlays.default
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "suikyo";
    homeDirectory = "/home/suikyo";

  };

  home.file."bin".source = ./bin;
  home.sessionPath = [ "${config.home.homeDirectory}/bin"];

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    chafa
    thunar
    file
    wakeonlan
    bind
  ];

  programs.bash.enable = true;

  programs.lf = {
    enable = true;
    previewer = {
      keybinding = "i";
      source = "${pkgs.ctpv}/bin/ctpv";
    };
    extraConfig = ''
      &${pkgs.ctpv}/bin/ctpv -s $id
      cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
      set sixel true
      '';
  };

  xdg.configFile."ctpv/config".text = ''
    set chafasixel
    '';

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings.user.name = "Suikyoo";
    settings.user.email = "judeanthony02sayson@gmail.com";
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extensions.packages = [
        pkgs.firefoxAddons."vimium-c"
      ];
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}
