-- this funcition will install packer if it is not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({ 'navarasu/onedark.nvim', as = 'onedark', })
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- tree sitter
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('nvim-treesitter/nvim-treesitter-textobjects')

  -- lsp
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},         -- Required
		  {'hrsh7th/cmp-nvim-lsp'},     -- Required
		  {'hrsh7th/cmp-buffer'},       -- Optional
		  {'hrsh7th/cmp-path'},         -- Optional
		  {'saadparwaiz1/cmp_luasnip'}, -- Optional
		  {'hrsh7th/cmp-nvim-lua'},     -- Optional

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},             -- Required
		  {'rafamadriz/friendly-snippets'}, -- Optional
	  }

  }

  use "ray-x/lsp_signature.nvim"

  -- navagation
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'scrooloose/nerdtree'
  use 'ggandor/leap.nvim'
  use {
    'ThePrimeagen/harpoon',
	requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use {
      "stevearc/oil.nvim",
      config = function() require("oil").setup() end,
  }

  -- ui
  use 'gcmt/taboo.vim'  -- trying this out... not sure if it works with neovim
  use 'mbbill/undotree'

  -- general programming plugins
  use 'janko-m/vim-test'
  use 'tomtom/tcomment_vim'
  use 'FooSoft/vim-argwrap'
  use 'github/copilot.vim'
  -- use {
	-- 'sourcegraph/sg.nvim',
  --   run = 'nvim -l build/init.lua',
	-- requires = { { 'nvim-lua/plenary.nvim' } }
  -- }

  -- git plugins
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- go
  use 'fatih/vim-go'
  use 'sebdah/vim-delve'

  -- bash
  use 'aliou/bats.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- This must be after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
