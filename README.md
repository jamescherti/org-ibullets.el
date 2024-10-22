# org-ibullets (Show org-mode headings bullets as UTF-8 characters)
![Build Status](https://github.com/jamescherti/org-ibullets.el/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/org-ibullets.el)
![](https://raw.githubusercontent.com/jamescherti/org-ibullets.el/main/.images/made-for-gnu-emacs.svg)

A minor mode for Emacs that enhances Org mode by displaying headings bullets as UTF-8 characters.

![screenshot](https://github.com/jamescherti/org-ibullets.el/raw/main/.images/screenshot.png)

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
  :commands org-ibullets-mode
  :straight (org-ibullets
             :type git
             :host github
             :repo "jamescherti/org-ibullets.el")
  :hook (org-mode . org-ibullets-mode))
```

### Manual installation

To install `org-ibullets`, clone the repository or download the `.el` file and add it to your Emacs load path, then add to your .emacs:
```
(require 'org-ibullets)
(add-hook 'org-mode-hook (lambda () (org-ibullets-mode 1)))
```

## FAQ / Troubleshooting

### What is the difference with org-bullets?

The `org-ibullets` package is based on the [MELPA org-bullets fork](https://github.com/integral-dw/org-bullets), which in turn is derived from the unmaintained [org-bullets](https://github.com/sabof/org-bullets).

Here are the improvements `org-ibullets`:
- **Optimizations (faster)**: `org-ibullets` has been optimized to eliminate redundant computations, such as repeated calls to functions like `(match-end 0)`. This reduction in unnecessary processing enhances performance, particularly in larger documents.
- **No syntax warnings**: Unlike `org-bullets`, which may generate syntax or font-lock warnings in certain Emacs configurations, `org-ibullets` resolves these issues, providing a smoother user experience.
- **Various enhancements**: Included `-*- lexical-binding: t; -*-`, improved readability and reduced redundancy, fixed warnings, added Melpazoid tests, implemented additional tests, and resolved fontification issues.

This revision improves clarity and flow while maintaining the original meaning.

### How can I further improve its speed?

I recommend adding the following to your Emacs init:
```emacs-lisp
(setq inhibit-compacting-font-caches t)
```

This variable also holds further information regarding what I believe is the cause of the problem.

## Alternatives

- [org-superstar](https://github.com/integral-dw/org-superstar-mode): A more complex alternative to `org-ibullets` that offers additional features beyond showing bullets as UTF-8 characters. **In contrast, org-ibullets is lightweight and focused on a single task.**

## Links

- [org-ibullets.el @GitHub](https://github.com/jamescherti/org-ibullets.el)
