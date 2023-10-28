# Dynamic Lazy Vimwiki Loader ... in Lua!

## Intro

This Lua snippet lets you define any number of vimwikis as Tables, and dynamically only
load the ones that are present on your computer. It also does a temporary `mapleader`
during the loading of vimwiki, so you can have a different leader key for those maps, and
then resets it at the end. Finally, it includes a way to run your diary files through an
external filter script.

I'm fairly new to Lua as of `git init` on this repo (this is day 9), so I may be doing
dumb things non-idiomatically (non-non-idiotically?).

## Dependencies

This repo assumes you are using:
- [Neovim](https://github.com/neovim/neovim)'s Lua API
- [Lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager
- [vimwiki](https://github.com/vimwiki/vimwiki) (duh)
- your deep powers of code perception

## Rationale

I wrote this because I have a vimwiki for my work laptop, and one for personal machines
that sadly isn't allowed to comingle with my work environment. I also use them slightly
differently to each other.

I try to keep my configs all in one place, and in one repo, and working across Mac OS and
Arch Linux (I use Arch, btw. And my name's Tom and I'm a genius, btw.) This means performing
simple environmental checks e.g. import file if exists, or `$HOSTNAME.conf`, checking 
`$OSTYPE`, etc.

This is trivial for things like Bash scripts or some config files, but needs a bit more
work with embedded code like Lua. The hard part this time was figuring out that you can't
just append to `vim.g.vimwiki_list` once set, and that merging tables in Lua is not obvious
to a beginner.

The important stuff in here is commented so you can learn if you're new, too.
