# Introduction
Hello! Welcome to my Neovim configuration. Below is the tentative roadmap for the future:

* Add debugging support with [vimspector](https://github.com/puremourning/vimspector) or [nvim-dap](https://github.com/mfussenegger/nvim-dap)

# External Dependencies
* [Git](https://git-scm.com/)
    - Required by [packer.nvim](https://github.com/wbthomason/packer.nvim) for plugin management.
    - Required by [vim-fugitive](https://github.com/tpope/vim-fugitive) for Git integration support.
* [Rustup](https://www.rust-lang.org/tools/install)
    - Toolchain manager for the [Rust programming language](https://www.rust-lang.org/).
    - Used for Rust language server support.
    - Required by [rust.vim](https://github.com/rust-lang/rust.vim) for Cargo integration.
* [Treesitter CLI](https://github.com/tree-sitter/tree-sitter)
    - Required by [Neovim's Treesitter integration](https://github.com/nvim-treesitter/nvim-treesitter) for parsing and highlighting support.
* [LLVM Toolchain](https://releases.llvm.org/download.html)
    - Required by [Neovim's Treesitter integration](https://github.com/nvim-treesitter/nvim-treesitter) for compiling C-based parsers.
* [fd](https://github.com/sharkdp/fd)
    - Required by [Telescope's built-in file picker](https://github.com/nvim-telescope/telescope.nvim#file-pickers).
* [ripgrep](https://github.com/BurntSushi/ripgrep)
    - Required by [Telescope's built-in file picker](https://github.com/nvim-telescope/telescope.nvim#file-pickers).

# Language Dependencies
* [Python](https://www.python.org/downloads/)
    - Used for Python language server support.
* [Deno](https://deno.land/)
    - Used for TypeScript development with Deno.
* [Clangd](https://clangd.llvm.org/)
    - Included with the [LLVM Toolchain](https://releases.llvm.org/download.html).
    - Used for C/C++ language server support.
* [Node.js](https://nodejs.org/en/download/current/)
    - Used for JavaScript/TypeScript language server support.
    - NPM also provides several other binaries used by some language servers.
* [CMake](https://cmake.org/download/)
    - Used for CMake-based C++ projects.
