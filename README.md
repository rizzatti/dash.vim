# dash.vim

This Vim plugin will search for terms using the excellent [Dash.app][Dash]
, making API lookups simple.

It provides a new :Dash family of commands and (recommended) mappings.

## Commands, Mappings and Configuration

Read the [help][vim-doc] to know more.

## Installation

### Using [Vundle][vundle]:

Just add this 2 lines to your `~/.vimrc`:

```vim
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
```

And run `:BundleInstall` inside Vim.

### Using [pathogen.vim][pathogen]:

Copy and paste in your shell:

```bash
cd ~/.vim/bundle
git clone https://github.com/rizzatti/funcoo.vim.git
git clone https://github.com/rizzatti/dash.vim.git
```

## License

MIT

[Dash]: http://kapeli.com/
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-doc]: http://vim-doc.heroku.com/view?https://raw.github.com/rizzatti/dash.vim/master/doc/dash.txt
[vundle]: https://github.com/gmarik/vundle
