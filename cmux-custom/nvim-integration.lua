--------------------------------------------- cmux -------------------------------------
local function smart_pane_navigate(direction)
	-- Map vim directions to cmux directions
	local direction_map = {
		h = "left",
		j = "down",
		k = "up",
		l = "right",
	}

	local cmux_direction = direction_map[direction]
	if not cmux_direction then
		return
	end

	-- Get current window number
	local current_win = vim.fn.winnr()

	-- Try to move within neovim first
	vim.cmd("wincmd " .. direction)

	-- Check if we actually moved
	local new_win = vim.fn.winnr()

	-- If we didn't move, we're at the edge - try to switch CMUX pane
	if current_win == new_win then
		local cmux_cmd = string.format("cmux focus-pane --direction %s", cmux_direction)
		vim.fn.system(cmux_cmd)
	end
end

-- Map Opt+h/j/k/l (using the escape sequences from Ghostty)
vim.keymap.set("n", "<M-h>", function()
	smart_pane_navigate("h")
end, { silent = true, desc = "Navigate left (neovim/cmux)" })
vim.keymap.set("n", "<M-j>", function()
	smart_pane_navigate("j")
end, { silent = true, desc = "Navigate down (neovim/cmux)" })
vim.keymap.set("n", "<M-k>", function()
	smart_pane_navigate("k")
end, { silent = true, desc = "Navigate up (neovim/cmux)" })
vim.keymap.set("n", "<M-l>", function()
	smart_pane_navigate("l")
end, { silent = true, desc = "Navigate right (neovim/cmux)" })
