-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end


return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")
  
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  use("szw/vim-maximizer") -- maximizes and restores current window

   -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
  use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

   -- commenting with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

   -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
  
  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  if packer_bootstrap then
    require("packer").sync()
  end
end)
