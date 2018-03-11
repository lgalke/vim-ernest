# vim-ernest

Ernest provides a modified insert mode for vim, in which all delete commands are disabled. 
Ernest is inspired by the `WRITE` mode of [Hemingway editor](http://www.hemingwayapp.com/)

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'lgalke/vim-ernest'
```

## Command

Ernest provides a single new command `:Ernest`, which enters the modified insert mode (Ernest mode).
For convenience, you can trigger Ernest mode by a mapping in your `vimrc`:

```vim
nnoremap A :Ernest<CR>
```

## Integration with other plugins

Ernest works great with [goyo.vim - Distraction-free writing in Vim](https://github.com/junegunn/goyo.vim).
To jump directly into Ernest mode after activating `:Goyo`, you can connect the two plugins via

```vim
autocmd! User GoyoEnter Ernest
```

## Limitations

- For now, previous insert mode maps are restored trivially via `inoremap`. In case you have more sophisticated insert mode mappings, feel free to help extending this plugin towards properly restoring those maps.
- The integration with Goyo is still experimental. When you exit Ernest mode inside Goyo, Goyo will not deactivate immediately.

## Example

Here is some example text, that I am just writing. I cannot delete anything and will commit it later exactly like this.
While it is may be a bit uncofortable in the first place, zou will get used to it.
This helps to clearly seperate editing from writing. As we all know, vim users tend to overly edit their text instead of actually produce text.
Well, that's maybe just me. HStill, you might want to give Ernest mode a try aswell.
