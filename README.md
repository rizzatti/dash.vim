# dash.vim

This Vim plugin will search for terms using the excellent [Dash.app][Dash]
, making API lookups simple.

It provides a new :Dash family of commands and (recommended) mappings.

WARNING: [Dash.app][Dash] is a Mac only application, so you will not benefit
from using dash.vim on Linux nor Windows. It can be installed on those systems
however, but it will not load.

## Commands, Mappings and Configuration

Read the [help][txt-doc] to know more.

## Installation

### Using [Vundle][vundle]:

Just add this line to your `~/.vimrc`:

```vim
Plugin 'rizzatti/dash.vim'
```

And run `:PluginInstall` inside Vim.

### Using [pathogen.vim][pathogen]:

Copy and paste in your shell:

```bash
cd ~/.vim/bundle
git clone https://github.com/rizzatti/dash.vim.git
```

### Using [vpm][vpm]:

Run this command in your shell:

```bash
vpm insert rizzatti/dash.vim
```

### Using [Plug][plug]:

Just add this line to your `~/.vimrc` inside plug call:

```vim
Plug 'rizzatti/dash.vim'
```

And run `:PlugInstall` inside Vim or `vim +PlugInstall +qa` from shell.

## License

MIT

[Dash]: http://kapeli.com/
[pathogen]: https://github.com/tpope/vim-pathogen
[txt-doc]: https://raw.githubusercontent.com/rizzatti/dash.vim/master/doc/dash.txt
[vpm]: https://github.com/KevinSjoberg/vpm
[vundle]: https://github.com/gmarik/vundle
[plug]: https://github.com/junegunn/vim-plug
