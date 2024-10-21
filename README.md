# org-ibullets (Show org-mode bullets as UTF-8 characters)
![Build Status](https://github.com/jamescherti/org-ibullets.el/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/org-ibullets.el)
![](https://raw.githubusercontent.com/jamescherti/org-ibullets.el/main/.images/made-for-gnu-emacs.svg)

A minor mode for Emacs that enhances Org mode by displaying UTF-8 bullets in headings.

![screenshot](https://github.com/jamescherti/org-ibullets.el/raw/main/screenshot.png)

## Features

- Replace standard Org mode bullets with visually appealing UTF-8 characters.
- Customizable bullet list for different heading levels.
- Supports inline tasks with appropriate bullet representation.
- Configurable face for bullets to match your theme.

## Installation

### Install using straight (preferred)

To install the `org-ibullets` using `straight.el`:

1. It if hasn't already been done, [add the straight.el bootstrap code](https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started) to your init file.
2. Add the following code to the Emacs init file:
```emacs-lisp
(use-package org-ibullets
  :ensure t
  :straight (org-ibullets
             :type git
             :host github
             :repo "jamescherti/org-ibullets.el"))
```

### Manual installation

To install `org-ibullets`, clone the repository or download the `.el` file and add it to your Emacs load path, then add to your .emacs:
```
(require 'org-ibullets)
(add-hook 'org-mode-hook (lambda () (org-ibullets-mode 1)))
```

## FAQ / Troubleshooting

### What is the difference with org-bullets?

- **Optimizations (faster)**: `org-ibullets` is optimized to avoid redundant computations, such as repeated calls to functions like `(match-end 0)`. By minimizing unnecessary processing, it provides better performance, especially in larger documents.
- **No syntax warnings**: Unlike `org-bullets`, which may trigger warnings related to syntax or font-lock handling in certain Emacs configurations, `org-ibullets` eliminates such issues.

### This mode causes significant slowdown

I recommend adding the following to your Emacs init:
```
(setq inhibit-compacting-font-caches t)
```

This variable also holds further information regarding what I believe is the cause of the problem.

## Alternatives

- [org-superstar](https://github.com/integral-dw/org-superstar-mode): A more complex alternative to org-ibullets that offers additional features beyond UTF-8 bullet support.
- [org-bullets fork](https://github.com/integral-dw/org-bullets) by D. Williams. The org-ibullets package is based on this Williams' fork.
- [Original org-bullets](https://github.com/sabof/org-bullets) by Sabof, the original version (unmaintained).

## Links

- [org-ibullets.el @GitHub](https://github.com/jamescherti/org-ibullets.el)
