;;; org-ibullets.el --- Show bullets in org-mode as UTF-8 characters -*- lexical-binding: t; -*-

;; Maintainer: James Cherti
;; URL: https://github.com/jamescherti/org-ibullets.el
;; Original Author: D. Williams <d.williams@posteo.net>
;; Original Author: Evgkeni Sampelnikof (Sabof)
;; Package-Requires: ((emacs "25.1"))
;; Keywords: maint
;; Version: 1.0.0
;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is NOT part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Show bullets in org-mode as UTF-8 characters.
;;
;; This project based on:
;; - org-bullets 0.2.4 by Evgkeni Sampelnikof
;; - org-bullets fork by D. Williams

;;; Code:

(require 'org)

(defgroup org-ibullets nil
  "Display bullets as UTF-8 characters in Org mode headings."
  :group 'org-appearance
  :prefix "org-ibullets-"
  :link '(url-link "https://github.com/jamescherti/org-ibullets.el"))

;; A nice collection of unicode bullets:
;; - Large: ♥ ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
;; - Small: ✸ • ★ ▸
(defcustom org-ibullets-bullet-list
  '("●" "◉" "○" "►" "▷" "□" "♦" "✚")
  "List of bullets used in Org mode headings.
These symbols will be cycled through for each heading level."
  :group 'org-ibullets
  :type '(repeat (string :tag "Bullet character")))

(defcustom org-ibullets-face-name nil
  "Face used for bullets in Org mode headings.
If set to a face, that face will be used for the bullets.
Otherwise, the heading level face will be used."
  :group 'org-ibullets
  :type 'symbol)

(defvar org-ibullets-bullet-map (make-sparse-keymap)
  "Keymap for Org mode bullets.")

(defun org-ibullets-level-char (level)
  "Return the appropriate bullet for the given heading LEVEL."
  (let* ((step (if org-odd-levels-only 2 1))
         (index (mod (/ (1- level) step) (length org-ibullets-bullet-list))))
    (string-to-char (nth index org-ibullets-bullet-list))))

(defvar org-ibullets--keywords
  `(("^\\*+ "
     (0 (let* ((heading-start (match-beginning 0))
               (heading-end (match-end 0))
               (level (- heading-end heading-start 1))
               (is-inline-task (and (boundp 'org-inlinetask-min-level)
                                    (>= level org-inlinetask-min-level)))
               (bullet-start (1- heading-end))
               (bullet-end (- heading-end 2))
               (bullet-char (org-ibullets-level-char level)))
          (compose-region bullet-end bullet-start
                          bullet-char)
          (when is-inline-task
            (compose-region (- heading-end 3) bullet-end bullet-char))
          (when (facep org-ibullets-face-name)
            (put-text-property (- heading-end (if is-inline-task 3 2))
                               bullet-start 'face
                               org-ibullets-face-name))
          (put-text-property heading-start bullet-end 'face 'org-hide)
          (put-text-property heading-start heading-end 'keymap
                             org-ibullets-bullet-map)
          nil)))))

(defun org-ibullets--fontify-buffer ()
  "Fontify the current buffer."
  (when font-lock-mode
    (save-restriction
      (widen)
      ;; This function marks the buffer (or a specific region) for
      ;; refontification, telling Emacs that the font lock information is
      ;; no longer valid and needs to be refreshed
      (when (fboundp 'font-lock-flush)
        (font-lock-flush))

      ;; This function ensures that fontification actually happens for the
      ;; specified region (or the entire buffer if no region is provided).
      (when (fboundp 'font-lock-ensure)
        (font-lock-ensure)))))

;;;###autoload
(define-minor-mode org-ibullets-mode
  "Use UTF-8 bullets in Org mode headings."
  :global nil
  :group 'org-ibullets
  (if org-ibullets-mode
      (font-lock-add-keywords nil org-ibullets--keywords)
    (save-excursion
      (goto-char (point-min))
      (font-lock-remove-keywords nil org-ibullets--keywords)
      (while (re-search-forward "^\\*+ " nil t)
        (decompose-region (match-beginning 0) (match-end 0)))))
  (org-ibullets--fontify-buffer))

(provide 'org-ibullets)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; org-ibullets.el ends here
