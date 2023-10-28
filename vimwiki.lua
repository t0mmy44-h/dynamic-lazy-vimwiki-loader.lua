-- Define your g:vimwiki_list as a Table
local wikis = {
  {
    path = vim.fn.expand("~/path/to/wiki/1/"), -- Trailing slash here [1]
    diary_template = "path/to/template/filter", -- some executable filter
    syntax = "markdown", -- or whatever
    ext = ".md", -- or whatever
    auto_tags = 1 -- ... or whatever! you do you, friend
  },
  {
    path = vim.fn.expand("~/path/to/wiki/2/"),
    diary_template = "path/to/template/filter2", -- I'll filter2 your filter2ing filter2
    syntax = "markdown",
    ext = ".md",
    auto_tags = 1
  },
  -- { another wiki if you like }
}

return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.mapleader = "\\" -- remap leader temporarily if you want to

      local diary_file = "diary/*.md"
      local wikilist = {}

      -- Hoopy Frood Loop
      for _,v in ipairs(wikis) do
        -- See if the wiki exists on this machine (you should `touch` it first if it's brand new)
        local wiki_here = vim.fn.filereadable(v.path .. "index.md") -- [1] Glad you left that trailing slash?

        if wiki_here == 1 then
          -- I'm new to lua, this might be dumb
          local wiki_def = {
            path = v.path,
            syntax = v.syntax,
            ext = v.ext,
            auto_tags = v.auto_tags
          }
          -- See above comment...
          table.insert(wikilist, wiki_def)

          -- use that template filter!
          vim.api.nvim_create_autocmd({"BufNewFile"}, {
            pattern = {v.path .. diary_file},
            command = ":silent 0r !" .. v.diary_template .. " '%'"
          })
        end
      end

      -- You can't mutate/append a vim.g, so you gotta build it up then assign
      vim.g.vimwiki_list = wikilist
    end,
    config = function()
      -- un-remap the vimwiki leader. I did this purely to keep muscle memory
      vim.g.mapleader = " " -- Space, the final frontier
    end
  }
}
