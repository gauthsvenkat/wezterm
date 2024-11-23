local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("update-right-status", function(window)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

return {
  audible_bell = "Disabled",

  enable_wayland = false,
  -- hack to make terminal similarly sized on both desktop and mac
  font_size = (wezterm.target_triple:find("linux") ~= nil) and 12.0 or 16.0,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_and_split_indices_are_zero_based = true,

  window_background_opacity = 0.9,

  leader = { key = "Enter", mods = "ALT" },
  key_tables = {
    resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "Escape", action = "PopKeyTable" },
    },
    rotate_pane = {
      { key = "h", action = act.RotatePanes("CounterClockwise") },
      { key = "j", action = act.RotatePanes("Clockwise") },
      { key = "k", action = act.RotatePanes("CounterClockwise") },
      { key = "l", action = act.RotatePanes("Clockwise") },
      { key = "Escape", action = "PopKeyTable" },
    },
    rotate_tab = {
      { key = "h", action = act.MoveTabRelative(-1) },
      { key = "j", action = act.MoveTabRelative(1) },
      { key = "k", action = act.MoveTabRelative(-1) },
      { key = "l", action = act.MoveTabRelative(1) },
      { key = "Escape", action = "PopKeyTable" },
    },
    split_pane = {
      { key = "h", action = act.SplitPane({ direction = "Left" }) },
      { key = "j", action = act.SplitPane({ direction = "Down", size = { Percent = 25 } }) },
      { key = "k", action = act.SplitPane({ direction = "Up" }) },
      { key = "l", action = act.SplitPane({ direction = "Right" }) },
    },
  },
  keys = {
    -- Spawning new tabs
    {
      key = "t",
      mods = "ALT",
      action = act.SpawnTab("DefaultDomain"),
    },
    -- Split panes
    {
      key = "p",
      mods = "ALT",
      action = act.ActivateKeyTable({
        name = "split_pane",
      }),
    },
    -- Navigating tabs
    {
      key = "n",
      mods = "ALT",
      action = act.ActivateTabRelative(1),
    },
    {
      key = "b",
      mods = "ALT",
      action = act.ActivateTabRelative(-1),
    },
    {
      key = "t",
      mods = "ALT|SHIFT",
      action = act.ShowTabNavigator,
    },
    -- Moving tabs
    {
      key = "m",
      mods = "ALT|SHIFT",
      action = act.ActivateKeyTable({
        name = "rotate_tab",
        one_shot = false,
      }),
    },
    -- Resizing panes
    {
      key = "r",
      mods = "ALT",
      action = act.ActivateKeyTable({
        name = "resize_pane",
        one_shot = false,
      }),
    },
    -- Navigating panes
    {
      key = "h",
      mods = "ALT",
      action = act.ActivatePaneDirection("Left"),
    },
    {
      key = "j",
      mods = "ALT",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "k",
      mods = "ALT",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "l",
      mods = "ALT",
      action = act.ActivatePaneDirection("Right"),
    },
    {
      key = "s",
      mods = "ALT",
      action = act.PaneSelect({ mode = "Activate" }),
    },
    -- Closing panes
    {
      key = "d",
      mods = "ALT",
      action = act.CloseCurrentPane({ confirm = true }),
    },
    -- Moving panes
    {
      key = "m",
      mods = "ALT",
      action = act.ActivateKeyTable({
        name = "rotate_pane",
        one_shot = false,
      }),
    },
    {
      key = "s",
      mods = "ALT|SHIFT",
      action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
    },
    -- Misc
    {
      key = "Enter",
      mods = "LEADER",
      action = act.ActivateCommandPalette,
    },
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = act.PasteFrom("Clipboard"),
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "ALT",
      action = act.OpenLinkAtMouseCursor,
    },
  },
}
