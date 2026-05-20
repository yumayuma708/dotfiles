local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ====================
-- 1. 見た目・色の設定
-- ====================

-- カラースキームの設定
config.color_scheme = 'AdventureTime'

-- 色の個別上書き
config.colors = {
  background = '#2d3139', -- お気に入りのダークグレー背景
  foreground = '#ffffff', -- 文字の色（白）
  cursor_bg = '#ffffff', -- カーソルの色（白）

  -- 【選択時のハイライト色：薄い水色】
  selection_bg = '#3e5f77',
  selection_fg = '#ffffff',

  -- ペイン仕切り線の色（WezTermでは split のみ有効）
  split = '#ffffff',
}

-- 非アクティブなペインを少し暗くして、アクティブなペインを目立たせる
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}

-- 背景透過（好みに合わせて調整してください）
config.window_background_opacity = 0.85

-- ====================
-- 2. フォントの設定
-- ====================
config.font = wezterm.font_with_fallback({
  'Menlo',
  'Hiragino Kaku Gothic ProN',
})
config.font_size = 18.0

-- ====================
-- 3. ショートカットキーの設定
-- ====================
local act = wezterm.action
config.keys = {
  -- Cmd + d で縦分割（左右に割る）
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Cmd + Shift + d で横分割（上下に割る）
  {
    key = 'D',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Alt(Opt) + Shift + f でフルスクリーン切り替え
  {
    key = 'f',
    mods = 'CMD|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = act.SendKey { key = 'Enter', mods = 'SHIFT' },
  },
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = act.SendString '\n',
  },
  -- Option + Enter で送信せず改行
  {
    key = 'Enter',
    mods = 'META',
    action = act.SendKey { key = 'Enter', mods = 'META' },
  },
  -- Ctrl + Shift + t で新しいタブを作成
  {
    key = 't',
    mods = 'SHIFT|CTRL',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- Ctrl + 左矢印で前の単語に移動
  {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = act.SendKey { key = 'b', mods = 'META' },
  },
  -- Ctrl + 右矢印で次の単語に移動
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = act.SendKey { key = 'f', mods = 'META' },
  },
  -- Ctrl + Backspace で前の単語を削除
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = act.SendKey { key = 'w', mods = 'CTRL' },
  },

  -- Cmd + Opt + ↓ : WezTermをhide（Cmd+Hと同じ挙動。Cmd+Tabや再度Cmd+Hで復帰）
  {
    key = 'DownArrow',
    mods = 'CMD|ALT',
    action = act.HideApplication,
  },
}

return config
