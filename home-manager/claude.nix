{ inputs, lib, config, pkgs, ... }: {

  home.packages = [ pkgs.nodejs_22 ];  # inked plugin's .mcp.json runs plain `node`

  programs.claude-code = {
    enable = true;
    context = "This machine is a server on nixos with its flake configuration at ~/nix. Claude code is ran through home-manager (~/nix/home-manager). Custom applications are mainly developed on other devices and cloned here to be ran as a docker compose stack in ~/compose. ~/compose/cloudflared is where the container for the cloudflare tunnel is run which spawns a docker network cloudflared-net. cloudlare-hosted applications don't expose their ports. Instead, they're compose files are configured to hook the to-be-exposed services unto the external network of cloudflared-net, along with an aliased name";


    plugins = let 
      claude-plugins-internal = [
        "frontend-design"
        "project-artifact"
        "ralph-loop"
        "skill-creator"
        "playground"
        "clangd-lsp"
        "gopls-lsp"
        "pyright-lsp"
        "typescript-lsp"
      ];

      claude-plugins-external = [
        "context7"
      ];

      claude-internal = lib.genAttrs claude-plugins-internal (x: "${inputs.claude-plugins}/plugins/${x}");
      claude-external = lib.genAttrs claude-plugins-external (x: "${inputs.claude-plugins}/external_plugins/${x}");


      others = {
        inked = "${inputs.inked-plugin}/plugin";
        superpowers = inputs.superpower-plugin;
      };

    in builtins.attrValues (lib.mergeAttrsList [ others claude-internal claude-external ]);

  };
}
