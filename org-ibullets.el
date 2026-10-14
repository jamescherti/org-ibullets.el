;;; org-ibullets.el --- Show bullets in org-mode as UTF-8 characters -*- lexical-binding: t; -*-

;; Maintainer: James Cherti
;; URL: https://github.com/jamescherti/org-ibullets.el
;; Original Author: D. Williams <d.williams@posteo.net>
;; Original Author: Evgkeni Sampelnikof (Sabof)
;; Package-Requires: ((emacs "25.1"))
;; Keywords: convenience, outlines, faces
;; Version: 1.0.2
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

(defvar org-inlinetask-min-level)

(defgroup org-ibullets nil
  "Display bullets as UTF-8 characters in Org mode headings."
  :group 'org-appearance
  :prefix "org-ibullets-"
  :link '(url-link
          :tag "Github"
          "https://github.com/jamescherti/org-ibullets.el"))

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
  :type '(choice (const :tag "Default (use heading level face)" nil) face))

(defvar org-ibullets-bullet-map (make-sparse-keymap)
  "Keymap for Org mode bullets.")

(defvar-local org-ibullets--bullet-chars nil
  "Cached vector of bullet characters derived from `org-ibullets-bullet-list'.")

(defvar-local org-ibullets--bullet-list-cache nil
  "Last `org-ibullets-bullet-list' to build `org-ibullets--bullet-chars'.")

(defsubst org-ibullets-level-char (level)
  "Return the appropriate bullet for the given heading LEVEL."
  (unless (and org-ibullets--bullet-chars
               (eq org-ibullets-bullet-list org-ibullets--bullet-list-cache))
    (setq org-ibullets--bullet-list-cache org-ibullets-bullet-list
          org-ibullets--bullet-chars
          (vconcat (delq 0 (mapcar #'string-to-char
                                   org-ibullets-bullet-list)))))
  (let ((len (length org-ibullets--bullet-chars)))
    (when (> len 0)
      (aref org-ibullets--bullet-chars
            (mod (if org-odd-levels-only (ash (1- level) -1) (1- level))
                 len)))))

(defun org-ibullets--fontify-heading ()
  "Fontify the bullet of the current Org mode heading match."
  (let* ((heading-start (match-beginning 0))
         (heading-end (match-end 0))
         (level (- heading-end heading-start 1))
         (is-inline-task (and (> level 2)
                              (bound-and-true-p org-inlinetask-min-level)
                              (>= level org-inlinetask-min-level)))
         (bullet-start (- heading-end 2))
         (bullet-end (1- heading-end))
         (hide-end (if is-inline-task (- heading-end 3) bullet-start))
         (bullet-char (org-ibullets-level-char level)))
    (when bullet-char
      (compose-region bullet-start bullet-end bullet-char)
      (when is-inline-task
        (compose-region hide-end bullet-start bullet-char)))
    (when (and org-ibullets-face-name (facep org-ibullets-face-name))
      (put-text-property hide-end bullet-end 'face org-ibullets-face-name))
    (when (< heading-start hide-end)
      (put-text-property heading-start hide-end 'face 'org-hide))
    (put-text-property heading-start heading-end 'keymap
                       org-ibullets-bullet-map)
    nil))

(defvar org-ibullets--keywords
  '(("^\\*+ "
     (0 (org-ibullets--fontify-heading)))))

(defun org-ibullets--fontify-buffer ()
  "Fontify the current buffer."
  ;; Fontify the buffer
  (when (and (bound-and-true-p font-lock-mode)
             ;; For maximum safety during a session load, check
             ;; `font-lock-set-defaults'. This variable guarantees that the
             ;; font-lock machinery has actually finished configuring its
             ;; keywords and syntax tables for the current buffer.
             (bound-and-true-p font-lock-set-defaults))
    (save-restriction
      (widen)
      (if (fboundp 'font-lock-flush)
          (font-lock-flush)
        (with-no-warnings
          (font-lock-fontify-buffer))))))

;;;###autoload
(define-minor-mode org-ibullets-mode
  "Use UTF-8 bullets in Org mode headings."
  :global nil
  :group 'org-ibullets
  (if org-ibullets-mode
      (progn
        (setq org-ibullets--bullet-list-cache nil)
        (make-local-variable 'font-lock-extra-managed-props)
        (dolist (prop '(composition keymap))
          (add-to-list 'font-lock-extra-managed-props prop))
        (font-lock-add-keywords nil org-ibullets--keywords))
    (font-lock-remove-keywords nil org-ibullets--keywords)
    (setq font-lock-extra-managed-props
          (delq 'composition
                (delq 'keymap font-lock-extra-managed-props)))
    (with-silent-modifications
      (save-excursion
        (save-restriction
          (widen)
          (goto-char (point-min))
          (while (re-search-forward "^\\*+ " nil t)
            (remove-text-properties (match-beginning 0) (match-end 0)
                                    '(composition nil keymap nil)))))))
  (org-ibullets--fontify-buffer))

(provide 'org-ibullets)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; org-ibullets.el ends here
