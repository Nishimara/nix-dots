{ ... }:
{
  programs.nixvim = {
    enable = true;
    
    autoCmd = [
      {
        event = [ "VimEnter" ];
        command = ":TransparentEnable";
      }
      {
        event = [ "VimLeave" ];
        command = ":set guicursor=a:ver20-blinkon500";
      }
    ];

    clipboard.providers.wl-copy.enable = true;

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      smartindent = true;
      expandtab = true;
    };

    colorschemes.dracula.enable = true;

    files = {
      "ftplugin/json.lua".opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
      "ftplugin/nix.lua".opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };

    plugins = {
      cmp = {
        enable = true;

        settings = {
          snippet.expand = "luasnip";

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "cmp_tabby"; }
            { name = "treesitter"; }
          ];
        };
      };

      colorizer.enable = true;

      comment.enable = true;
      gitsigns.enable = true;
      hmts.enable = true;
      illuminate.enable = true;
      luasnip.enable = true;

      lsp = {
        enable = true;

        servers = {
          clangd.enable = true;
          ts_ls.enable = true;
          nixd.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      neo-tree.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      transparent.enable = true;

      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          indent.enable = true;
        };
      };

      web-devicons.enable = true;
    };
  };
}