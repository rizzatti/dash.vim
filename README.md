# dash.vim

This Vim plugin will search for terms using the excellent [Dash][Dash]
app, making API lookups simple.

It provides a new :Dash command and (recommended) mappings.

Read the [help][vim-doc] to know more.

## Commands

### :Dash

```
:Dash
```

Will search for the word under the cursor in Dash, considering the
current filetype in Vim.

```
:Dash String
```

Will search for 'String' in Dash, considering the current filetype.

```
:Dash String ruby
```

Will search for 'String' in the 'ruby' docset, regardless of the current
filetype.

Tip: You can hit `<Tab>` to complete the docset name.

```
:Dash!
```
Will search for the word under the cursor in all docsets (globally).

```
:Dash! func
```

Will search for 'func' in all docsets.

### :DashDocsets

Shows a message listing all docset keywords available in the system.

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

## Configuration

Please, check the [help][vim-config].

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
[vim-config]: http://vim-doc.heroku.com/view?https://raw.github.com/zehrizzatti/dash.vim/master/doc/dash.txt#DashConfig
