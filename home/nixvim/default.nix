{ pkgs, ...}:
{
  programs.nixvim = {
    enable = true;
    
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
      tabstop = 4;
      smartindent = true;
      expandtab = true;
    };

    files = {
      "ftplugin/json.lua".opts = {
        shiftwidth = 2;
        tabstop = 2;
      };
    };

    plugins = {
      lsp = {
        enable = true;

      	servers = {
	        tsserver.enable = true;
	        clangd.enable = true;
	        rust-analyzer = {
	          enable = true;
	          installCargo = false;
	          installRustc = false;
	        };
	      };
      };

      cmp.enable = true;

      nix.enable = true;
      treesitter.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      illuminate.enable = true;
      nvim-colorizer.enable = true;
      auto-session.enable = true;
      comment.enable = true;
    };
  };
}