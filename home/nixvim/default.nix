{ pkgs, ...}:
{
  programs.nixvim = {
    enable = true;
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

      nvim-cmp = {
        enable = true;

        sources = [
          { name = "nvim_lsp"; }
          { name = "treebuffer"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      nix.enable = true;
      treesitter.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      illuminate.enable = true;
      nvim-colorizer.enable = true;
      auto-session.enable = true;
      comment-nvim.enable = true;
    };
  };
}