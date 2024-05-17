vim.g.mapleader = " "
vim.o.nu = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.mouse = "a"

vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.clipboard = "unnamedplus" -- same as system clipboard

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

vim.o.completeopt = "menuone,noselect"

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.o.updatetime = 50

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
vim.o.termguicolors = true

vim.lsp.inlay_hint.enable(true)

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{ "projekt0n/github-nvim-theme" },
	{ "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "mbbill/undotree" },
	{ "noib3/cokeline.nvim", requires = "kyazdani42/nvim-web-devicons" },
	-- { 'akinsho/bufferline.nvim',                version = "*" },
	{ "numToStr/Comment.nvim", opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "j-hui/fidget.nvim", opts = {} }, -- LSP status updates
		},
	},

	{ "mfussenegger/nvim-dap", dependencies = { "rcarriga/nvim-dap-ui" } },
	{ "github/copilot.vim" },
	{ "tpope/vim-fugitive" },
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "simrat39/symbols-outline.nvim" },
	{ "folke/neodev.nvim", opts = {} },

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
})

-- keymaps
vim.keymap.set(
	"n",
	"<leader>r",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "Replace word under cursor" }
)

vim.keymap.set("n", "so", ":e $MYVIMRC<CR>", { desc = "Open init.lua" })
vim.keymap.set("n", "H", vim.cmd.bprevious, { desc = "Buffer previous" }) -- ':bprev<CR>')
vim.keymap.set("n", "L", vim.cmd.bnext, { desc = "Buffer next" }) -- ':bprev<CR>')

vim.keymap.set("n", "<leader>`", ":b#<CR>", { desc = "Switch to last buffer" })
vim.keymap.set("n", "<leader>q", vim.cmd.bd, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save buffer" })
vim.keymap.set("n", "<c-e>", vim.cmd.Hex, { desc = "Open Hex" })

-- keep indent while moving block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
-- join lines while keeping current position
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
-- keep line centered while jumping/searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to previous match" })
-- term exit
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
-- paste over without losing current register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over" })
-- quickfix/locationlilst list (copen, lopen)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous Location List" })
-- delete into void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete into void" })
-- toggle inlay hints
vim.keymap.set(
	"n",
	"<leader>i",
	"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
	{ desc = "Toggle Inlay Hints" }
)

local wk = require("which-key")
wk.register({
	["<leader>"] = {
		g = {
			name = "+Git",
		},
	},
})

vim.cmd.colorscheme("github_dark_dimmed")
require("neodev").setup({})
--require('bufferline').setup({})
require("cokeline").setup({})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>f", builtin.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "All files Live Grep" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find in Buffers" })
vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>l", builtin.current_buffer_fuzzy_find, { desc = "Find in Current Buffer" })

local neotree = require("neo-tree")
-- neo tree toggle
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })
neotree.setup({
	filesystem = {
		-- list of directories to ignore
		ignore = { ".git", "node_modules", ".cache" },
		-- list of files to ignore
		hidden = { ".gitignore", ".gitmodules", ".DS_Store" },
		-- show hidden files
		show_hidden = false,
		-- width of the window
		width = 30,
		hijack_netrw_behavior = "open_default",
	},
})

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

-- conform formatter
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },
		rust = { "rustfmt" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("lualine").setup({})
-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "c", "rust" },
	sync_install = true,
	auto_install = true,

	highlight = {
		enable = true,
		-- enable = false,
		additional_vim_regex_highlighting = false,
	},
	modules = {},
	ignore_install = {},
})
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer" },
})

local lsp = require("lsp-zero").preset({})
lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	local opts = { buffer = bufnr, remap = false, desc = "Go to definition" }
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
end)
lsp.setup()

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
})

require("toggleterm").setup({
	direction = "horizontal",
	open_mapping = [[<c-\>]],
})

require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				features = "all",
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			-- workspace = {
			--     checkThirdParty = true,
			-- },
		},
	},
})

require("symbols-outline").setup()
