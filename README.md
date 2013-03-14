# dash.vim

This Vim plugin will search for terms using the excellent [Dash][Dash]
app, making API lookups simple.

It provides a new :Dash command and (recommended) mappings.

Read the (TODO :) [help][vim-doc] to know more.

## Commands

This plugin has one command: `Dash`.

```
:Dash String
```

Will search for 'String' in Dash, considering the current filetype in Vim.

```
:Dash! func
```

Will search for 'func' in all Docsets (globally) inside Dash.

## Mappings

This plugin will not create automatic mappings in your behalf, but let's
you choose if you want to use them :)

There are 2 for now:

* `<Plug>DashFiletype`: Searches for the word under the cursor,
  considering the current filetype.
* `<Plug>DashGlobal`: Searches for word under the cursor in all docsets.

To use them, add something like this to your ~/.vimrc:

```vim
nmap <silent> <Leader>d <Plug>DashFiletype
nmap <silent> <Leader>D <Plug>DashGlobal
```

## Installation

If you don't have a preferred installation method, I recommend
installing [pathogen.vim][pathogen], and then simply copy and paste:

```bash
cd ~/.vim/bundle
git clone https://github.com/zehrizzatti/dash.vim.git
```

## License

MIT

[Dash]: http://kapeli.com/
[pathogen]: https://github.com/tpope/vim-pathogen
[vim-doc]: http://vim-doc.heroku.com/view?https://raw.github.com/zehrizzatti/dash.vim/master/doc/dash.txt
