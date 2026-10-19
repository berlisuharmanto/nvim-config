-- Softer colors for text that defaults to stark white (#ffffff).
-- - In Dark Mode: Uses a soft off-white/silver (#d4d4d8) to eliminate blinding eye-strain.
-- - In Light Mode: Uses a clean, highly-readable charcoal gray (#374151) so text is never invisible white on light backgrounds.
-- - Applies automatically across all themes, theme switches, and background toggles.

local soft_dark_hex = "#d4d4d8"
local soft_light_hex = "#374151"
local soft_dark_int = 0xd4d4d8
local soft_light_int = 0x374151

-- Groups that represent standard/foreground text elements
local core_groups = {
  "Normal",
  "NormalNC",
  "@variable",
  "@variable.builtin",
  "@lsp.type.variable",
  "@operator",
  "Operator",
  "Delimiter",
  "@punctuation.delimiter",
  "@punctuation.bracket",
  "@type.builtin",
  "phpRegion",
  "phpParent",
}

local function is_target_white(color_int)
  if not color_int then
    return false
  end
  if color_int == soft_dark_int or color_int == soft_light_int then
    return true
  end
  local r = bit.band(bit.rshift(color_int, 16), 0xff)
  local g = bit.band(bit.rshift(color_int, 8), 0xff)
  local b = bit.band(color_int, 0xff)
  -- Match pure white (#ffffff) or near-white (>= 235 on all channels)
  return r >= 235 and g >= 235 and b >= 235
end

local function is_light_mode()
  if vim.o.background == "light" then
    return true
  end

  local theme_name = (vim.g.colors_name or ""):lower()
  if theme_name:find("light") or theme_name:find("latte") or theme_name:find("day") then
    return true
  end

  -- Check Omarchy's active theme mode if available
  local colors_file = vim.fn.expand("~/.local/state/omarchy/current/theme/colors.toml")
  if vim.fn.filereadable(colors_file) == 1 then
    local lines = vim.fn.readfile(colors_file, "", 15)
    for _, l in ipairs(lines) do
      if l:find("mode%s*=%s*\"light\"") or l:find("mode%s*=%s*\x27light\x27") then
        return true
      end
    end
  end

  return false
end

local function apply_softer_colors()
  local is_light = is_light_mode()
  local target_hex = is_light and soft_light_hex or soft_dark_hex

  -- 1. Ensure core text and delimiter groups use the target color
  for _, name in ipairs(core_groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if ok and hl then
      local new_hl = vim.deepcopy(hl)
      new_hl.fg = target_hex
      vim.api.nvim_set_hl(0, name, new_hl)
    end
  end

  -- 2. Dynamically scan all defined highlights; soften any group that uses pure/near-white
  -- while strictly preserving other syntax colors (blue, yellow, magenta, cyan, green, etc.)
  local all_hls = vim.api.nvim_get_hl(0, {})
  for name, hl in pairs(all_hls) do
    if hl.fg and is_target_white(hl.fg) then
      local new_hl = vim.deepcopy(hl)
      new_hl.fg = target_hex
      vim.api.nvim_set_hl(0, name, new_hl)
    end
  end
end

-- Apply on startup
apply_softer_colors()

-- Autocommand to re-apply on any theme load, background toggle, or VimEnter
local augroup = vim.api.nvim_create_augroup("SofterWhiteThemeAdapter", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = augroup,
  callback = function()
    -- Small defer to ensure colorscheme and transparency handlers finish setting highlights
    vim.defer_fn(apply_softer_colors, 10)
  end,
  desc = "Apply softer colors for white text in dark and light modes",
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = augroup,
  pattern = "background",
  callback = function()
    vim.defer_fn(apply_softer_colors, 10)
  end,
  desc = "Re-apply softer colors when background changes between light and dark",
})

-- User command to manually re-apply if ever needed
vim.api.nvim_create_user_command("SofterWhiteReload", apply_softer_colors, {
  desc = "Re-apply softer white/gray colors to highlight groups",
})
