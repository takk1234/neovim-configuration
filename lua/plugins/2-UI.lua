-- UI Plugins

local core = require("core")
local icons = {
	ui = core.gets("ui"),
	git = core.gets("git"),
	diagnostics = core.gets("diagnostics"),
}

local default = {

	-- catppuccin/nvim -> [A Soothing pastel theme for (Neo)vim]
	-- https://github.com/catppuccin/nvim

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			background = { light = "latte", dark = "mocha" },
			transparent_background = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			show_end_of_buffer = false,
			term_colors = true,
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			styles = {
				comments = { "bold" },
				functions = { "bold" },
				keywords = { "bold" },
				operators = { "bold" },
				conditionals = { "bold" },
				loops = { "bold" },
				booleans = { "bold", "italic" },
				numbers = {},
				types = {},
				strings = {},
				variables = {},
				properties = {},
			},
			integrations = {
				treesitter = true,
				alpha = false,
				notify = true,
				cmp = true,
				dashboard = false,
				gitsigns = true,
				indent_blankline = { enabled = true, colored_indent_levels = true },
				markdown = true,
				mason = true,
				telescope = { enabled = true, style = "nvchad" },
			},
			color_overrides = {},
			highlight_overrides = {
				all = function(cp)
					return {
						CursorLineNr = { fg = cp.green },

						WhichKeyBorder = { fg = cp.red },

						NoiceCmdlinePopupBorder = { fg = cp.teal },
						NoiceCmdlineIcon = { fg = cp.teal },
						NoiceCmdlinePopupTitle = { fg = cp.teal },

						["@keyword.return"] = { fg = cp.pink, style = {} },
						["@error.c"] = { fg = cp.none, style = {} },
						["@error.cpp"] = { fg = cp.none, style = {} },
					}
				end,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			require("catppuccin").load()
		end,
	},

	-- dashboard-nvim -> [A vim dashboard, greeter for neovim]
	-- https://github.com/nvimdev/dashboard-nvim

	{
		{
			"nvimdev/dashboard-nvim",
			event = "BufWinEnter",
			lazy = true,
			opts = function()
				local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
            ]]

				logo = string.rep("\n", 8) .. logo .. "\n\n"

				local opts = {
					theme = "doom",
					hide = {
						statusline = false,
						tabline = false,
					},
					config = {
						header = vim.split(logo, "\n"),
                        -- stylua: ignore
                        center = {
                            { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
                            { action = 'lua require("core").create_file()', desc = " New File", icon = " ", key = "n" },
                            { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
                            { action = "Telescope colorscheme", desc = " Change Background", icon = " ", key = "t" },
                            { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                            { action = 'e $MYVIMRC', desc = " Configuration", icon = " ", key = "c" },
                            { action = "qa", desc = " Quit Neovim", icon = " ", key = "q" },
                        },
						footer = function()
							local stats = require("lazy").stats()
							local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
							return {
								"⚡ Neovim loaded "
									.. stats.loaded
									.. "/"
									.. stats.count
									.. " plugins in "
									.. ms
									.. "ms",
							}
						end,
					},
				}

				for _, button in ipairs(opts.config.center) do
					button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
					button.key_format = "  %s"
				end

				return opts
			end,
		},
	},

	-- mini.indentscope -> [Neovim Lua plugin to visualize and operate on indent scope]
	-- https://github.com/echasnovski/mini.indentscope

	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- bufferline.nvim -> [A snazzy bufferline for Neovim]
	-- https://github.com/akinsho/bufferline.nvim

	{
		"akinsho/bufferline.nvim",
		tags = "*",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		opts = {
			options = {
			number = nil,
			buffer_close_icon = icons.ui.Close,
			left_trunc_marker = icons.ui.Left,
			right_trunc_marker = icons.ui.Right,
			max_name_length = 20,
			max_prefix_length = 13,
			tab_size = 20,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			enforce_regular_tabs = false,
			persist_buffer_sort = true,
			always_show_bufferline = true,
			separator_style = "thin",
			diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count)
				return "(" .. count .. ")"
			end,
			},
		},
		keys = {
			{
				"<leader>b",
				"<Cmd><leader>b<CR>",
				desc = icons.ui.Buffer .. "Buffer",
			},
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		},
		config = function(_, opts)
			vim.opt.termguicolors = true
			require("bufferline").setup(opts)
		end,
	},

	-- lualine.nvim -> [A blazing fast and easy to configure neovim statusline plugin]
	-- https://github.com/nvim-lualine/lualine.nvim

	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		init = function()
			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,

		opts = function()
			-- Color table for highlights
			local colors = {
				yellow = "#ECBE7B",
				cyan = "#008080",
				darkblue = "#081633",
				green = "#98be65",
				orange = "#FF8800",
				violet = "#a9a1e1",
				magenta = "#c678dd",
				blue = "#51afef",
				red = "#ec5f67",
			}

			local conditionals = {
				has_enough_room = function()
					return vim.o.columns > 100
				end,
				has_comp_before = function()
					return vim.bo.filetype ~= ""
				end,
				has_git = function()
					local gitdir = vim.fs.find(".git", {
						limit = 1,
						upward = true,
						type = "directory",
						path = vim.fn.expand("%:p:h"),
					})
					return #gitdir > 0
				end,
			}

			return {
				options = {
					theme = require("core").theme(),
					component_separators = "",
					disabled_filetypes = { statusline = { "dashboard" } },
					section_separators = { left = "", right = "" },
				},
				extensions = { "toggleterm" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = {},
					lualine_c = {
						{ "filetype", icon_only = false, padding = { left = 1, right = 0 }, separator = " " },

						{
							function()
								return "%="
							end,
						},

						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							sections = { "error", "warn", "info", "hint" },
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warning,
								info = icons.diagnostics.Information,
								hint = icons.diagnostics.Hint_alt,
							},
							diagnostics_color = {
								color_error = { fg = colors.red },
								color_warn = { fg = colors.yellow },
								color_info = { fg = colors.cyan },
							},
						},

						{
							function()
								local msg = "No Active Lsp"
								local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
								local clients = vim.lsp.get_active_clients()
								if next(clients) == nil then
									return msg
								end
								for _, client in ipairs(clients) do
									local filetypes = client.config.filetypes
									if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
										return client.name
									end
								end
								return msg
							end,
							icon = " LSP:",
							color = { fg = "#ffffff", gui = "bold" },
						},
					},
					lualine_x = {

						{
							function()
								return require("core").lsp_progress()
							end,
						},

						{
							"location",
						},

						{
							"branch",
							cond = conditionals.has_git,
						},

						{
							"diff",
							symbols = {
								added = icons.git.Add,
								modified = icons.git.Mod_alt,
								removed = icons.git.Remove,
							},
							diff_color = {
								added = { fg = colors.green },
								modified = { fg = colors.orange },
								removed = { fg = colors.red },
							},
							cond = conditionals.has_git,
						},

						{
							function()
								return "▊"
							end,
							color = { fg = colors.blue },
							padding = { left = 1 },
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,

		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	-- nvim-notify -> [A fancy, configurable, notification manager for NeoVim]
	-- https://github.com/rcarriga/nvim-notify

	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				stages = "fade",
				timeout = 3000,
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { zindex = 100 })
				end,
			})

			vim.cmd([[
                    highlight NotifyERRORBorder guifg=#BF616A
                    highlight NotifyWARNBorder guifg=#D08770
                    highlight NotifyINFOBorder guifg=#A3BE8C
                    highlight NotifyDEBUGBorder guifg=#BFBFBF
                    highlight NotifyTRACEBorder guifg=#B48EAD

                    highlight NotifyERRORIcon guifg=#BF616A
                    highlight NotifyWARNIcon guifg=#D08770
                    highlight NotifyINFOIcon guifg=#A3BE8C
                    highlight NotifyDEBUGIcon guifg=#BFBFBF
                    highlight NotifyTRACEIcon guifg=#B48EAD

                    highlight NotifyERRORTitle  guifg=#BF616A
                    highlight NotifyWARNTitle guifg=#D08770
                    highlight NotifyINFOTitle guifg=#A3BE8C
                    highlight NotifyDEBUGTitle  guifg=#BFBFBF
                    highlight NotifyTRACETitle  guifg=#B48EAD

]])

			vim.notify = require("notify")
		end,
	},

	-- nvim-scrollview -> [Displays interactive vertical scrollbars and signs]
	-- https://github.com/dstein64/nvim-scrollview

	{
		"dstein64/nvim-scrollview",
		lazy = true,
		event = { "CursorHold", "CursorHoldI" },
		config = function()
			require("scrollview").setup({
				mode = "virtual",
				excluded_filetypes = { "NvimTree", "terminal", "nofile", "aerial" },
				winblend = 0,
				signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },
				diagnostics_error_symbol = icons.diagnostics.Error,
				diagnostics_warn_symbol = icons.diagnostics.Warning,
				diagnostics_info_symbol = icons.diagnostics.Information,
				diagnostics_hint_symbol = icons.diagnostics.Hint,
			})
		end,
	},

	{
		"folke/which-key.nvim",
		lazy = true,
		event = { "CursorHold", "CursorHoldI" },
		init = function() end,
		opts = {

			plugins = {
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = true,
					g = true,
				},
			},
			disable = { filetypes = { "TelescopePrompt" } },
			layout = {
				height = { min = 3, max = 25 },
				align = "center",
			},
			icons = {
				group = "",
			},
			window = {
				border = "double",
				position = "bottom",
				margin = { 1, 0, 1, 0 },
				padding = { 1, 1, 1, 1 },
				winblend = 0,
			},
		},
		config = function(_, opts)
			vim.o.timeout = true
			require("which-key").setup(opts)
		end,
	},
}

return default
