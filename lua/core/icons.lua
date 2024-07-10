local M = {}


local icons = {
	-- AUTO COMPLETION --
	kind = {
		Class = "󰠱",
		Color = "󰏘",
		Constant = "󰏿",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "󰇽",
		File = "󰈙",
		Folder = "󰉋",
		Fragment = "",
		Function = "󰊕",
		Interface = "",
		Implementation = "",
		Keyword = "󰌋",
		Method = "󰆧",
		Module = "",
		Namespace = "󰌗",
		Number = "",
		Operator = "󰆕",
		Package = "",
		Property = "󰜢",
		Reference = "",
		Snippet = "",
		Struct = "",
		Text = "󰉿",
		TypeParameter = "󰅲",
		Undefined = "",
		Unit = "",
		Value = "󰎠",
		Variable = "",
		-- ccls-specific icons.
		TypeAlias = "",
		Parameter = "",
		StaticMethod = "",
		Macro = "",
	}, -- -- -- -- -- -- -- -- -- --

	-- Base Icon --

	type = {
		Array = "󰅪",
		Boolean = "",
		Null = "󰟢",
		Number = "",
		Object = "󰅩",
		String = "󰉿",
	},

	git = {
		Add = "",
		Branch = "",
		Diff = "",
		Git = "󰊢",
		Ignore = "",
		Mod = "M",
		Mod_alt = "",
		Remove = "",
		Rename = "",
		Repo = "",
		Unmerged = "󰘬",
		Untracked = "󰞋",
		Unstaged = "",
		Staged = "",
		Conflict = "",
	},

	ui = {
		Accepted = "",
		ArrowClosed = "",
		ArrowOpen = "",
		BigCircle = "",
		BigUnfilledCircle = "",
		BookMark = "󰃃",
		Buffer = "󰓩",
		Bug = "",
		Calendar = "",
		Character = "",
		Check = "󰄳",
		ChevronRight = "",
		Circle = "",
		Close = "󰅖",
		Close_alt = "",
		CloudDownload = "",
		CodeAction = "󰌵",
		Comment = "󰅺",
		Dashboard = "",
		Emoji = "󰱫",
		EmptyFolder = "",
		EmptyFolderOpen = "",
		File = "󰈤",
		Fire = "",
		Folder = "",
		FolderOpen = "",
		FolderWithHeart = "󱃪",
		Gear = "",
		History = "󰄉",
		Incoming = "󰏷",
		Indicator = "",
		Keyboard = "",
		Left = "",
		List = "",
		Square = "",
		SymlinkFolder = "",
		Lock = "󰍁",
		Modified = "✥",
		Modified_alt = "",
		NewFile = "",
		Newspaper = "",
		Note = "󰍨",
		Outgoing = "󰏻",
		Package = "",
		Pencil = "󰏫",
		Perf = "󰅒",
		Play = "",
		Project = "",
		Right = "",
		RootFolderOpened = "",
		Search = "󰍉",
		Separator = "",
		DoubleSeparator = "󰄾",
		SignIn = "",
		SignOut = "",
		Sort = "",
		Spell = "󰓆",
		Symlink = "",
		Tab = "",
		Table = "",
		Telescope = "",
		Window = "",
		Message = "",
	},
	diagnostics = {
		Error = "",
		Warning = "",
		Information = "",
		Question = "",
		Hint = "󰌵",
		-- Holo version
		Error_alt = "󰅚",
		Warning_alt = "󰀪",
		Information_alt = "",
		Question_alt = "",
		Hint_alt = "󰌶",
	},
	misc = {
		Campass = "󰀹",
		Code = "",
		Gavel = "",
		Glass = "󰂖",
		NoActiveLsp = "󱚧",
		PyEnv = "󰢩",
		Squirrel = "",
		Tag = "",
		Tree = "",
		Watch = "",
		Lego = "",
		LspAvailable = "󱜙",
		Vbar = "│",
		Add = "+",
		Added = "",
		Ghost = "󰊠",
		ManUp = "",
		Neovim = "",
		Vim = "",
		Package = "",
		LSP = "",
	},

	tools = {
		Session = "",
		Terminal = "",
		Telescope = "",
		TelescopePrompt = "",
		Selected = "❯",
	},
}

--- @brief a custom function used to get icon from a specific table (category).
--- @param category string
M.gets = function(category, _)
	if not vim.g.icons_enabled then
		return ""
	end
	return setmetatable({}, {
		__index = function(_, key)
			return icons[category][key] .. " "
		end,
	})
end


return M
