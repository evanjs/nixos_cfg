local nvim_lsp = require'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.rust_analyzer.setup({
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true
				},
			}
		}
	})

--local lsp_installer = require("nvim-lsp-installer")

--lsp_installer.on_server_ready(function(server)
	--local opts = {}

	--if server.name == "rust_analyzer" then
		---- initialize the lsp via rust-tools instead
		--require("rust-tools").setup {
			---- the "server" property provided in rust-tools setup function are the
			---- settings rust-tools will provide to lspconfig during init.            --
			---- we merge the necessary settings from nvim-lsp-installer (server:get_default_options())
			---- with the user's own settings (opts).
			--server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
		--}
		--server:attach_buffers()
		---- only if standalone support is needed
		--require("rust-tools").start_standalone_if_required()
	--else
		--server:setup(opts)
	--end
--end)

