;;; dos2unix.el --- convert line-endings in Emacs   -*- lexical-binding: t; -*-

;; Copyright (C) 2021 Case Duckworth

;; Author: Case Duckworth <acdw@acdw.ne

;;; License:

;; Everyone is permitted to do whatever with this software, without
;; limitation.  This software comes without any warranty whatsoever,
;; but with two pieces of advice:

;; - Be kind to yourself.

;; - Make good choices.

;;; Commentary:

;; The dos2unix command-line program is amazing, but it doesn't run in Emacs
;; directly, which means that on, say, Windows, it's a real pain to get setup
;; right.  This package emulates that functionality within Emacs so that you
;; can use it wherever you can use Emacs.

;;; Code:

(defun dos2unix-region (start end)
  "Replace \\r\\n with \\n between START and END."
  (interactive "*r")
  (save-excursion
    (goto-char start)
    (while (search-forward (string ?\C-m ?\C-j) nil t)
      (replace-match (string ?\C-j) nil t))))

(defun dos2unix-buffer (buffer)
  "Replace \\r\\n with \\n in BUFFER."
  (interactive "*b")
  (with-current-buffer buffer
    (dos2unix-region (point-min) (point-max))))

(defun dos2unix-dwim ()
  "Replace \\r\\n with \\n in active region or current buffer."
  (interactive)
  (if (region-active-p)
      (dos2unix-region (region-beginning) (region-end))
    (dos2unix-region (point-min) (point-max))))

(provide 'dos2unix)
;;; dos2unix.el ends here
