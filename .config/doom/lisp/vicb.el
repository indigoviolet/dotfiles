;;; vicb.el --- Source for consult-buffers  -*- lexical-binding: t; -*-

;; Copyright © 2022 Venky Iyer

;; Author: Venky Iyer <indigoviolet@gmail.com>
;; URL: https://github.com/indigoviolet/vi-consult-buffers
;; Version: 0.1.0
;; Keywords: matching tools files
;; Package-Requires: ((emacs "26.1") (ts "0.3-pre") (f "0.20.0") (dash "2.19.0") (consult "0.18"))

;; This file is not a part of GNU Emacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Personalized source for consult-buffers

;;; Code:

(require 'consult)
(require 'dash)
(require 'f)
(require 'ht)
(require 'ts)

;; Don't allow default value current-time on nil -- ts-format, time-to-seconds
;; and make-ts all return current-time if passed nil. This is super confusing
;; when dealing with buffer-display-time which can be nil for other reasons.
(defalias 'vicb--ts-format (-andfn #'identity #'ts-format))
(defalias 'vicb--time-to-seconds (-andfn #'identity #'time-to-seconds))
(defsubst vicb--make-unix-ts (tm) (--when-let tm (make-ts :unix tm)))

(defsubst vicb--buffer-display-time-raw (buf)
  "Get raw emacs timestamp for buffer-display-time"
  (buffer-local-value 'buffer-display-time buf))

(defsubst vicb--buffer-display-time (buf)
  "Return buffer-display-time in seconds
  (or -1 if nil -- this is useful for sorting)"
  (or (vicb--time-to-seconds (vicb--buffer-display-time-raw buf)) -1))

(defun vicb--tvp (keyfn cmp eqp)
  "Predicates like #'> return t for a > b and nil otherwise. This makes it
  difficult to combine predicates for secondary sort, since we don't have the
  equality case.

  vicb--tvp constructs three-valued predicates:
  - nil if eqp(keyfn(a),keyfn(b)),
  - t if cmp(keyfn(a),keyfn(b)),
  - else '(nil)

  So only the equality case is falsey; and we can use --some to return the first
  non-equality case."
  (lambda (a b)
    (-let ((ak (funcall keyfn a))
           (bk (funcall keyfn b)))
      (cond
       ;; true if cmp(ak, bk)
       ((funcall cmp ak bk) t)
       ;; nil if eqp(ak, bk)
       ((funcall eqp ak bk) nil)
       ;; '(nil) otherwise
       (t '(nil))))))


(defun vicb--tvp-comp-stack (&rest preds)
  "Combines three-valued predicates for secondary sort."
  (lambda (a b)
    (-let [pv (--some (funcall it a b) preds)]
      ;; And convert back to two-valued, for use with -sort
      (equal pv t))))

;; Comparator predicates for time | alpha
(defalias 'vicb--name-comp-tvp (vicb--tvp #'buffer-name #'string< #'equal))
(defalias 'vicb--time-comp-tvp (vicb--tvp #'vicb--buffer-display-time #'> #'equal))
(defalias 'vicb--buf-comp (vicb--tvp-comp-stack #'vicb--time-comp-tvp #'vicb--name-comp-tvp))

(defsubst vicb--buf-sort (bufs) (-sort #'vicb--buf-comp bufs))

(defsubst vicb--hidden-buf (buf)
  "Does buffer name begin with spc"
  (s-starts-with? " " (buffer-name buf)))

(defsubst vicb--buffer-list ()
  "Buffer list, which will set :items in the new source"
  (-let* (
          ;; Remove current-buffer
          (bufs (-remove-item (current-buffer) (buffer-list)))
          ;; Hold back buffers that begin with SPC
          ((h nh) (-separate #'vicb--hidden-buf bufs))
          ;; Separate out "real" buffers (*ein* buffers pass this test)
          ((t1 others) (-separate #'doom-real-buffer-p nh))
          ;; Sort each bunch separately
          (sorted (-map #'vicb--buf-sort (list t1 others h))))
    ;; And concatenate
    (-flatten sorted)))


(defun vicb-consult--source-buffer ()
  "Construct a consult-buffers source by modifying consult--source-buffer"
  (-let [csb (ht<-plist consult--source-buffer)]
    (ht-set! csb :items (lambda () (-map #'buffer-name (vicb--buffer-list))))
    (ht-set! csb :name "Buffer (vicb)")
    (ht->plist csb)))

(defun vicb-setup ()
  "Mutate consult--source-buffer so that we don't have to mess around with order
  in consult-buffer-sources"
  (setq consult--source-buffer (vicb-consult--source-buffer)))

(defsubst vicb--ts-format-unix (tm)
  "Format a unix time for display"
  (vicb--ts-format (vicb--make-unix-ts (vicb--time-to-seconds tm))))

(defsubst vicb--buffer-display-time-s (buf)
  "Format buffer-display-time for display"
  (vicb--ts-format-unix (vicb--buffer-display-time-raw buf)))

(defsubst vicb--buf-info (buf)
  "Debugging function

  Use like

  (mapcar #'vicb--buf-info (vicb--buffer-list))"
  (list
   (buffer-name buf)
   ;; (vicb--buffer-last-visited buf)
   (vicb--buffer-display-time buf)
   (vicb--buffer-display-time-s buf)))

;; (defsubst vicb--buffer-last-visited-s (buf)
;;   (vicb--ts-format-unix (vicb--time-to-seconds (buffer-local-value 'vicb--buffer-last-visited buf))))
;; (mapcar #'vicb--buf-info (vicb--buffer-list))
;; (defvar-local vicb--buffer-last-visited nil "Last visited.")
;; (require 'ts)
;; (defun vicb-update-last-visited ()
;;     (setq-local vicb--buffer-last-visited (ts-unix (ts-now))))
;; (add-hook! '(doom-switch-buffer-hook doom-switch-window-hook) #'vicb-update-last-visited)

(provide 'vicb)
;;; vicb.el ends here

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
