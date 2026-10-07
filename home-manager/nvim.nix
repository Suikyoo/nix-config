{ inputs, lib, config, pkgs, ... }: {

  home.packages = with pkgs; [
    lua-language-server
      nil                      # Nix LSP (or nixd)
      pyright
      rust-analyzer
      clang-tools              # clangd
      typescript-language-server
      stylua
      ruff
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      lua-language-server
      ];
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      blink-cmp
      mason-lspconfig-nvim
      nvim-tree-lua
      nvim-treesitter
    ];
      
  };

  xdg.configFile."nvim".source = ./config/nvim;
}
