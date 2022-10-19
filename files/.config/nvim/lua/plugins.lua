local ensure_packer = function()
	local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

local map = require("utils").map

return require("packer").startup(
	function(use)
		use {
			"wbthomason/packer.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"rafi/awesome-vim-colorschemes",
			"tpope/vim-eunuch",
			"vim-airline/vim-airline",
			"kyazdani42/nvim-web-devicons",
			"kyazdani42/nvim-tree.lua",
			"romgrk/barbar.nvim",
		}
		if packer_bootstrap then
			require("packer").sync()
		end
		vim.g.loaded = 1
		vim.g.loaded_netrwPlugin = 1
		require "nvim-web-devicons".setup()
		require "nvim-tree".setup()

		map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
		map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
		map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
		map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
		map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
		map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
		map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
		map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
		map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
		map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
		map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
		map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
		map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
		map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
		map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
		map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
		map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
		map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
		map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
		map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
		map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

		local nvim_tree_events = require('nvim-tree.events')
		local bufferline_state = require('bufferline.state')
		local function get_tree_size()
			return require 'nvim-tree.view'.View.width
		end

		nvim_tree_events.subscribe('TreeOpen', function()
			bufferline_state.set_offset(get_tree_size())
		end)
		nvim_tree_events.subscribe('Resize', function()
			bufferline_state.set_offset(get_tree_size())
		end)
		nvim_tree_events.subscribe('TreeClose', function()
			bufferline_state.set_offset(0)
		end)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "sumneko_lua", "rust_analyzer" }
		})

		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set('n', '<space>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set('n', '<space>f', function() vim.lsp.buf.formatting { async = true } end, bufopts)
		end

		local lsp_flags = {
			debounce_text_changes = 150,
		}
		require('lspconfig')['sumneko_lua'].setup {
			on_attach = on_attach,
			flags = lsp_flags,
		}
		require('lspconfig')['rust_analyzer'].setup {
			on_attach = on_attach,
			flags = lsp_flags,
			settings = {
				["rust-analyzer"] = {}
			}
		}
	end
)
