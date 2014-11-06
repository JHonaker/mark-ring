# Mark-ring Atom package

Easily create multiple cursors without your mouse.

![A screencast of mark-ring in action](https://raw.githubusercontent.com/JHonaker/mark-ring/master/mark-ring.gif)

This package allows you to create multiple cursors in places other than simply above and below the current cursors. All you need to remember is one easy-to-use shortcut that does everything!

## Features

* Mark your cursor location with a keyboard shortcut
* Use the mouse or keyboard to place another cursor
* No need to worry about moving cursors by accident
* Platform independent keyboard shortcuts

## Installation

Use apm: `apm install mark-ring`

Or install through the Atom setting menu.

## Shortcuts and Commands

The available commands for binding are:

* `mark-ring:mark-or-recall` - The main "do it all" command
* `mark-ring:view-marks` - Will open the mark view popover
* `mark-ring:mark-cursor` - Will *only* mark under the cursor
* `mark-ring:clear-marks` - Will clear all marks
* `mark-ring:recall-marks` - Will recall all marks, but not clear them

You only need `mark-ring:mark-or-recall` to use this package. It will mark under your cursor, but if there is a mark already there, it wil clear and recall all marks.

By default only these keybindings are set up:

##### Mac

* `CMD-SHIFT-M`: `mark-ring:mark-or-recall`
* `CMD-SHIFT-V`: `mark-ring:view-marks`

##### Windows/Linux

* `CTRL-SHIFT-M`: `mark-ring:mark-or-recall`
* `CTRL-SHIFT-V`: `mark-ring:view-marks`

The rest are still available through the command palette or you own custom keybindings.

If anyone has any suggestions or ideas, open an issue or submit a pull request!

## Acknowledgements:

This package was inspired by the [Must Have Packages That Don't Exist thread](https://discuss.atom.io/t/must-have-packages-that-dont-exist/12665) and the [MarkAndMove SublimeText package](https://github.com/colinta/SublimeMarkAndMove).

I heavily borrowed from the [atom-bookmarks](https://github.com/atom/bookmarks) package. The code in that package was instrumental getting this to work.
