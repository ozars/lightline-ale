# lightline-ycm

This plugin provides [YCM] indicator for the [lightline] vim plugin with
a similar look and API used by [lightline-ale]. See [Notes](#notes) for their
differences.

[YCM]: https://github.com/Valloric/YouCompleteMe
[lightline]: https://github.com/itchyny/lightline.vim
[lightline-ale]: https://github.com/maximbaz/lightline-ale

![screenshot](./screenshot.png)

## Table Of Contents

* [Installation](#installation)
* [Integration](#integration)
* [Configuration](#configuration)
* [Notes](#notes)
* [License](#license)

## Installation

Install using a plugin manager of your choice, for example:

```viml
call dein#add('Valloric/YouCompleteMe')   " Dependency: linter
call dein#add('itchyny/lightline.vim')    " Dependency: status line
call dein#add('maximbaz/lightline-ycm')
```

## Integration

1. Register the components:

```viml
let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ycm#checking',
      \  'linter_warnings': 'lightline#ycm#warnings',
      \  'linter_errors': 'lightline#ycm#errors',
      \  'linter_ok': 'lightline#ycm#ok',
      \ }
```

2. Set color to the components:

```viml
let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
```

3. Add the components to the lightline, for example to the right side:

```viml
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
```

## Configuration

##### `g:lightline#ycm#indicator_checking`

**This message is currently unused in lightline-ycm. See [Notes](#notes) for details.**

##### `g:lightline#ycm#indicator_warnings`

The indicator to use when there are warnings. Default is the value of
`g:lightline#ale#indicator_warnings` if set, otherwise `W:`.

##### `g:lightline#ycm#indicator_errors`

The indicator to use when there are errors. Default is the value of
`g:lightline#ale#indicator_errors` if set, otherwise `E:`.

##### `g:lightline#ycm#indicator_ok`

The indicator to use when there are no warnings or errors. Default is the value
of `g:lightline#ale#indicator_errors` if set, otherwise `OK`.

### Using icons as indicators

If you would like to replace the default indicators with symbols like on the screenshot, then you'll need to ensure you have some "iconic fonts" installed, such as [Font Awesome](https://fontawesome.com). A common alternative is to replace your primary font with one of the [Patched Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), which saves you from having to install multiple fonts.

The following icons from the Font Awesome font are used in the screenshot:

* Checking: [f110](https://fontawesome.com/icons/spinner)
* Warnings: [f071](https://fontawesome.com/icons/exclamation-triangle)
* Errors: [f05e](https://fontawesome.com/icons/ban)
* OK: [f00c](https://fontawesome.com/icons/check) (although I prefer to disable this component)

To specify icons in the configuration, use their unicode codes as `"\uXXXX"` (make sure to wrap them in double quotes). Alternatively copy the icons from a font website, or type <kbd>\<C-v\>u\<4-digit-unicode\></kbd> or <kbd>\<C-v\>U\<8-digit-unicode\></kbd> to insert the literal characters.

See the code points here:

* Font Awesome: https://fontawesome.com/icons
* Nerd Fonts: https://github.com/ryanoasis/nerd-fonts#glyph-sets

Here's the configuration snippet used in the screenshot:

```viml
let g:lightline#ycm#indicator_checking = "\uf110"
let g:lightline#ycm#indicator_warnings = "\uf071"
let g:lightline#ycm#indicator_errors = "\uf05e"
let g:lightline#ycm#indicator_ok = "\uf00c"
```

## Notes

- **`lightline#ycm#checking` does not work.** It is provided just for keeping
compatibility with lightline-ale API. YCM does not support any linter events in
its API as of today. It returns just an empty string currently.

- Status line update is checked on `CursorMove` and `CursorHold` events for
the same reason. The update will be called only if the number of errors or
warnings have changed since the last call.

- Feel free to submit PRs in case you come up with some ideas about removing
this limitations.

## License

Released under the [MIT License](LICENSE)
