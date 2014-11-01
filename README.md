# mark-ring package

Inspired by the [Must Have Packages That Don't Exist thread](https://discuss.atom.io/t/must-have-packages-that-dont-exist/12665) and the [MarkAndMove ST package](https://github.com/colinta/SublimeMarkAndMove), I decided to implement an easier way to create mulitple cursors with only the keyboard.

`CMD-SHIFT-M` Marking cursors

`CMD-SHIFT-R` Recall Marker

`CMD-SHIFT-C` Clear All Marks

Mark ring view all for the popover menu.

![A screenshot of your mark-ring](https://raw.githubusercontent.com/JHonaker/mark-ring/master/mark-ring.gif)

# TODO:

If anyone has any suggestions or ideas, open an issue or submit a pull request!

[X] Create mark at cursor

    [ ] Toggle Mark won't remove mark

[X] Remove all marks

[ ] Move to next/previous mark

[X] View and move to marks in popover

[X] Create cursors at marks in buffer

[ ] Platform independent bindings by default

Acknowledgements:

I heavily borrowed from the [atom-bookmarks](https://github.com/atom/bookmarks) package. The code in that package was instrumental getting this to work.
