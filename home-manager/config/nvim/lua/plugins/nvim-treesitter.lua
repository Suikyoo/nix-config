-- C:\MinGW\bin\gcc.exe (32-bit "mingw32") sits earlier on PATH than the
-- 64-bit mingw64 gcc, so nvim-treesitter was compiling 32-bit parser DLLs
-- that a 64-bit nvim.exe cannot dlopen ("not a valid Win32 application").
-- Force the 64-bit compiler explicitly instead of relying on PATH order.
require("nvim-treesitter.install").compilers = {
  "C:/Users/user/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/bin/gcc.exe",
}

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,

  },
  indent = {
    enable = true;
  }
}

-- nvim-treesitter's legacy query_predicates.lua (this plugin's "master" branch
-- is frozen/unmaintained) still does `local node = match[capture_id]` and calls
-- `node:range()` on it. Modern Neovim's query engine always hands directives a
-- TSNode[] list for match[capture_id] (even for a single, unquantified
-- capture), so `node` here is a list without a `range` method, which crashes
-- with "attempt to call method 'range' (a nil value)" the moment a markdown
-- buffer has a fenced code block with a language tag, e.g. ```lua``` (the
-- (#set-lang-from-info-string! ...) directive drives code-block injection).
-- Force-load the broken registrations, then override them with corrected
-- versions that unwrap the list the way Neovim's own built-in directives do
-- (see vim/treesitter/query.lua's `offset!`/`gsub!`: `local node = match[id][1]`).
require("nvim-treesitter.query_predicates")
local tsquery = require("vim.treesitter.query")

local html_script_type_languages = {
  importmap = "json",
  module = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}
local non_filetype_match_injection_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}
local function get_parser_from_markdown_info_string(injection_alias)
  local match = vim.filetype.match { filename = "a." .. injection_alias }
  return match or non_filetype_match_injection_language_aliases[injection_alias] or injection_alias
end

tsquery.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local node = match[pred[2]] and match[pred[2]][1]
  if not node then
    return
  end
  local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
  metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
end, { force = true, all = false })

tsquery.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
  local node = match[pred[2]] and match[pred[2]][1]
  if not node then
    return
  end
  local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
  local configured = html_script_type_languages[type_attr_value]
  if configured then
    metadata["injection.language"] = configured
  else
    local parts = vim.split(type_attr_value, "/", {})
    metadata["injection.language"] = parts[#parts]
  end
end, { force = true, all = false })

tsquery.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local node = match[id] and match[id][1]
  if not node then
    return
  end
  local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
  if not metadata[id] then
    metadata[id] = {}
  end
  metadata[id].text = string.lower(text)
end, { force = true, all = false })
