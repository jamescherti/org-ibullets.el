# org-bullets mode

Show org-mode bullets as UTF-8 characters.

![screenshot](https://github.com/emacsorphanage/org-bullets/raw/master/screenshot.png)

## Installation

Copy the file somewhere in your `load-path`, then add something like
this to your init file.

```lisp
(require 'org-bullets)
(add-hook 'org-mode-hook 'org-bullets-mode)
```
