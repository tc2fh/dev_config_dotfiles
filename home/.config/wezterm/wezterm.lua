local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

-- Appearance
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 13.0

-- Fetch the built-in Terminix Dark (Gogh) palette
local terminix_colors = wezterm.color.get_builtin_schemes()['Terminix Dark (Gogh)']

-- Override just the background and foreground for higher contrast
terminix_colors.background = '#05080e'
terminix_colors.foreground = '#e0e0e0'

-- Register it as a new custom scheme
config.color_schemes = {
  ['Terminix Dark (High Contrast)'] = terminix_colors,
}

-- Actually use the custom scheme
config.color_scheme = 'Terminix Dark (High Contrast)'

-- Transparency
-- 0.82 is more readable cross-platform; use 0.70 if you want the very transparent look.
config.window_background_opacity = 0.7

-- macOS transparency blur
config.macos_window_background_blur = 15

-- Windows blur/translucency effect
-- Acrylic works on Windows 10 and 11.
config.win32_system_backdrop = 'Acrylic'

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Window/tab behavior
config.enable_tab_bar = true
config.initial_cols = 120
config.initial_rows = 32
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Hide the OS title bar (min/max/close buttons) but keep resizable borders
config.window_decorations = 'RESIZE'

-- Scrollback
config.scrollback_lines = 10000

-- Universal keybindings for macOS + Windows
config.keys = {
  -- Command palette / reload config
  { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

  -- Copy / paste
  -- Keeps the same behavior on macOS and Windows.
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  -- Tabs
  { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },

  -- Close current tab
  { key = 'x', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = true } },

  -- Split panes
  -- Split right
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- Split down
  {
    key = '_',
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- Close current pane
  -- If this is the last pane in the tab, it closes the tab.
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = act.CloseCurrentPane { confirm = true },
  },

  -- Move between panes
  { key = 'LeftArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Resize panes
  { key = 'LeftArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },

  -- Zoom/unzoom current pane
  { key = 'z', mods = 'CTRL|SHIFT', action = act.TogglePaneZoomState },

  -- Move current pane into a new tab
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      pane:move_to_new_tab()
    end),
  },
}

return config