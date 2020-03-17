# org-bullets mode

## About

Show org-mode bullets as UTF-8 characters.

__NOTE:__ This is a legacy package maintained with a focus on
preservation.  It has an unofficial successor package
([org-superstar](https://github.com/integral-dw/org-superstar-mode)).
This means that new features will no longer be added, and backwards
compatibility will be preserved.

It's unofficial successor package is available on MELPA.

![screenshot](https://github.com/emacsorphanage/org-bullets/raw/master/screenshot.png)


## Installation

Copy the file somewhere in your `load-path`, then add something like
this to your init file.

```lisp
(require 'org-bullets)
(add-hook 'org-mode-hook 'org-bullets-mode)
```
