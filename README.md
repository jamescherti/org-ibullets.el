# org-ibullets (Show org-mode headings bullets as UTF-8 characters)
![Build Status](https://github.com/jamescherti/org-ibullets.el/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/github/license/jamescherti/org-ibullets.el)
![](https://jamescherti.com/misc/made-for-gnu-emacs.svg)

A minor mode for Emacs that enhances Org mode by displaying headings bullets as UTF-8 characters.

![screenshot](https://github.com/jamescherti/org-ibullets.el/raw/main/.images/screenshot.png)

## Features

- Replace standard Org mode bullets with visually appealing UTF-8 characters.
- Customizable bullet list for different heading levels.
- Supports inline tasks with appropriate bullet representation.
- Configurable face for bullets to match your theme.

## Installation

### Install with straight (preferred)

To install `org-ibullets` with `straight.el`:

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

Other Emacs packages by the same author:
- [minimal-emacs.d](https://github.com/jamescherti/minimal-emacs.d): This repository hosts a minimal Emacs configuration designed to serve as a foundation for your vanilla Emacs setup and provide a solid base for an enhanced Emacs experience.
- [outline-indent.el](https://github.com/jamescherti/outline-indent.el): An Emacs package that provides a minor mode that enables code folding and outlining based on indentation levels for various indentation-based text files, such as YAML, Python, and other indented text files.
- [vim-tab-bar.el](https://github.com/jamescherti/vim-tab-bar.el): Make the Emacs tab-bar Look Like Vim’s Tab Bar.
- [easysession.el](https://github.com/jamescherti/easysession.el): Easysession is lightweight Emacs session manager that can persist and restore file editing buffers, indirect buffers/clones, Dired buffers, the tab-bar, and the Emacs frames (with or without the Emacs frames size, width, and height).
- [elispcomp](https://github.com/jamescherti/elispcomp): A command line tool that allows compiling Elisp code directly from the terminal or from a shell script. It facilitates the generation of optimized .elc (byte-compiled) and .eln (native-compiled) files.
- [tomorrow-night-deepblue-theme.el](https://github.com/jamescherti/tomorrow-night-deepblue-theme.el): The Tomorrow Night Deepblue Emacs theme is a beautiful deep blue variant of the Tomorrow Night theme, which is renowned for its elegant color palette that is pleasing to the eyes. It features a deep blue background color that creates a calming atmosphere. The theme is also a great choice for those who miss the blue themes that were trendy a few years ago.
- [Ultyas](https://github.com/jamescherti/ultyas/): A command-line tool designed to simplify the process of converting code snippets from UltiSnips to YASnippet format.
- [dir-config.el](https://github.com/jamescherti/dir-config.el): Automatically find and evaluate .dir-config.el Elisp files to configure directory-specific settings.
- [flymake-bashate.el](https://github.com/jamescherti/flymake-bashate.el): A package that provides a Flymake backend for the bashate Bash script style checker.
- [flymake-ansible-lint.el](https://github.com/jamescherti/flymake-ansible-lint.el): An Emacs package that offers a Flymake backend for `ansible-lint`.
- [stripspace.el](https://github.com/jamescherti/stripspace.el): Ensure Emacs Automatically removes trailing whitespace before saving a buffer, with an option to preserve the cursor column.
- [persist-text-scale.el](https://github.com/jamescherti/persist-text-scale.el): Ensure that all adjustments made with text-scale-increase and text-scale-decrease are persisted and restored across sessions.
- [pathaction.el](https://github.com/jamescherti/pathaction.el): Execute the pathaction command-line tool from Emacs. The pathaction command-line tool enables the execution of specific commands on targeted files or directories. Its key advantage lies in its flexibility, allowing users to handle various types of files simply by passing the file or directory as an argument to the pathaction tool. The tool uses a .pathaction.yaml rule-set file to determine which command to execute. Additionally, Jinja2 templating can be employed in the rule-set file to further customize the commands.
