# vim-ernest

Ernest provides a modified insert mode for vim, in which all delete commands are disabled. 
Ernest is inspired by the pure writing mode of the [Hemingway editor](http://www.hemingwayapp.com/).
Thus, the name `Ernest` fits.

## Installation


### Plug
Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'lgalke/vim-ernest'
```

### Pathogen

Using [pathogen](https://github.com/tpope/vim-pathogen):

```
cd ~/.vim/bundle && git clone https://github.com/lgalke/vim-ernest.git
```

### Traditional way

Just put the `ernest.vim` file into your `vim/plugin` directory.

### Native Vim8 Package

For more information about native packages in `vim>=8`, please consult `:help packages`.

```
mkdir -p ~/.vim/pack/lgalke/start/
cd !!:2
git clone https://github.com/lgalke/vim-ernest.git
```

## Usage

Ernest provides a single new command:

```vim
:Ernest
```

The `:Ernest` command enters the modified insert mode (Ernest mode).
For convenience, you can trigger Ernest mode by a mapping in your `vimrc`, e.g.:

```vim
nnoremap A :Ernest<CR>
```

**Important:** Only `<Esc>` will leave Ernest mode. There is no other way out. (If you still find one, please let me know)

## Configuration

The default list of "evil keys" that Ernest will deactivate in insert mode is:

```vim
let g:ernest_evil_keys = ['<BS>', '<C-H>', '<Del>', '<C-W>', '<C-U>', '<C-C>', '<C-O>']
```

You can configure these keys manually in your vimrc, when desired.

## Integration with other plugins

### Goyo + Ernest

Ernest works great with [goyo.vim - Distraction-free writing in Vim](https://github.com/junegunn/goyo.vim).
Goyo is a plugin that provides a distraction-free writing mode for vim. It hides all the clutter (line numbers, statusline, ...)
and centers the text to focus on.  To jump directly into Ernest mode after
activating `:Goyo`, you can connect the two plugins via

```vim
autocmd! User GoyoEnter Ernest
autocmd! User ErnestLeave Goyo!
```

### Goyo + Limelight + Ernest

[Limelight](https://github.com/junegunn/limelight.vim) is a plugin that
modifies the highlighting such that only the current paragraph is highlighted.
You can bind all this functionality to the single `:Goyo` command via:

```vim
autocmd! User GoyoEnter Limelight | Ernest
autocmd! User ErnestLeave Limelight! | Goyo!
```

Now when entering `:Goyo<CR>`, both Limelight and Ernest are activated. When
leaving insert mode via `<Esc>`, Goyo and Limelight will be deactivated.


## Limitations

- For now, previous insert mode maps are restored trivially via `inoremap`. In
  case you have more sophisticated insert mode mappings, feel free to help
  extending this plugin towards properly restoring those maps. Proper restoring of mappings is [not so easy](https://vi.stackexchange.com/questions/7734/how-to-save-and-restore-a-mapping).
- Load time can be further decreased by putting the two functions into
  `autoload` directory rather than `plugin`. The plugin is so small (31 loc), however,
  that it won't hurt startuptime too much.

## Examples

```
Here is some example text, that I am just writing. I cannot delete anything and will commit it later exactly like this.
While it is may be a bit uncofortable in the first place, zou will get used to it.
This helps to clearly seperate editing from writing. As we all know, vim users tend to overly edit their text instead of actually produce text.
Well, that's maybe just me. HStill, you might want to give Ernest mode a try aswell.
```
```
Yet another bunch of text for testing the integration of Ernest in Goyo.
I just added an option to also call `Goyo!` when Ernest  mode is shut down.
Lets find out if oit works >:) 
```

```
Okay now that was kind of funny, I added the functionality for `ErnestLeave` only inside the github plugin directory but did not pull the changes into my local vim installation.
Thus, it did not work. Lets just give it another try...
```

```
Great it works, now I am checking whtehter this config does not breka. the usual Ernest ode outside of Goyo
```

`</ernest>` It works aswell ;) Happy writing!

## Advanced

Curious of permanently replacing insert mode with Ernest mode? No problem.

```vim
augroup permanent_ernest
  au!
  au InsertEnter * Ernest
  au InsertLeave * Ernest!
augroup END
```

This is maybe not desirable for coding, though.

## Closing words

Ernest provides an alternative insert mode for vim to focus on writing.
All deletion keys are disabled in Ernest mode. Ernest integrates nicely with other
plugins that focus on distraction-free writing, such as Goyo and Limelight. If
you enjoy `vim-ernest`, please consider leaving one of your stars. Let me know
whether this plugin has helped you to focus on actual writing rather than
editing.


