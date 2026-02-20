# Neovim Configuration

## System Requirements

The following external tools must be installed. Refer to each project for installation instructions.

| Tool                                                            | Purpose                              |
| --------------------------------------------------------------- | ------------------------------------ |
| [Git](https://github.com/git/git)                               | Plugin management via `lazy.nvim`    |
| [Ripgrep](https://github.com/BurntSushi/ripgrep)                | Live grep in Telescope               |
| [fd](https://github.com/sharkdp/fd)                             | File finding in Telescope            |
| [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter) | Installing Treesitter grammars       |
| [CMake](https://github.com/Kitware/CMake)                       | Building `telescope-fzf-native.nvim` |
| [Ninja](https://github.com/ninja-build/ninja)                   | Building `telescope-fzf-native.nvim` |

A modern C compiler (e.g., GCC or Clang) is also required for compiling Treesitter grammars and `telescope-fzf-native.nvim`.
