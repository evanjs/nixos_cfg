{ config, pkgs, lib, programs, ... }:
with lib;
{
  programs.nixvim = {
    extraConfigLuaPre = ''
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- Enable inlay hints by default if supported by client
          if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(args.buf, true)
          end
        end
      })
    '';

    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            "g[" = "goto_prev";
            "g]" = "goto_next";
          };
        };

        servers = {
          clangd.enable = true;
          cmake.enable = true;
        };
      };
    };
  };
}
