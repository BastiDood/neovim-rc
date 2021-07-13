# Introduction
Hello! Welcome to my Neovim configuration. It's not as clean as I would like it to be, but it works&trade; at the moment! Below is the tentative roadmap for the future:

* Conform to the Neovim's standard [runtime directory structure](https://www.youtube.com/watch?v=pjtfd5otTHg)
* Fully migrate configurations to [Lua](https://github.com/nanotee/nvim-lua-guide)
* Fully migrate from [coc.nvim](https://github.com/neoclide/coc.nvim) to [Native LSP](https://github.com/neovim/nvim-lspconfig)

# External Dependencies
The following programs are required to be installed for the configurations to work.
1. [Git](https://git-scm.com/)
    - Required by [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.
    - Required by [vim-fugitive](https://github.com/tpope/vim-fugitive) for Git integration support.
2. [Node.js](https://nodejs.org/en/download/current/)
    - Required by [coc.nvim](https://github.com/neoclide/coc.nvim) for language server management.
3. [Treesitter CLI](https://github.com/tree-sitter/tree-sitter)
    - Required by [Neovim's Treesitter integration](https://github.com/nvim-treesitter/nvim-treesitter) for parsing and highlighting support.
4. [LLVM Toolchain](https://releases.llvm.org/download.html)
    - Required by [Neovim's Treesitter integration](https://github.com/nvim-treesitter/nvim-treesitter) for compiling C-based parsers.
5. [fd](https://github.com/sharkdp/fd)
    - Required by [Telescope's built-in file picker](https://github.com/nvim-telescope/telescope.nvim#file-pickers).

# Optional Dependencies
The following dependencies are used merely for language support with [coc.nvim](https://github.com/neoclide/coc.nvim). The full list of language servers can be found in the configuration as the global variable `g:coc_global_extensions`.
1. [Rustup](https://www.rust-lang.org/tools/install)
    - Toolchain manager for the [Rust programming language](https://www.rust-lang.org/).
    - Used for Rust language server support.
2. [Python](https://www.python.org/downloads/)
    - Used for Python language server support.
3. [Deno](https://deno.land/)
    - Used for TypeScript development with Deno.
4. [Clangd](https://clangd.llvm.org/)
    - Included with the [LLVM Toolchain](https://releases.llvm.org/download.html).
    - Used for C/C++ language server support.
5. [CMake](https://cmake.org/download/)
    - Used for CMake-based C++ projects.
