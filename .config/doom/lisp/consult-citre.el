;;; consult-citre.el --- Consult integration for Citre (Ctags) -*- lexical-binding: t; -*-

(require 'citre)
(require 'consult)
(require 'consult-xref)

(defun consult-citre-readtags--build-cmd (tagsfile &optional name match case-fold filter sorter action)
  "Build a readtags command for Citre.
TAGSFILE is the path to the tags file. NAME, MATCH, CASE-FOLD, FILTER, SORTER
are as documented in `citre-readtags-get-tags`. ACTION can be nil (for regular tags)
or a valid readtags action flag (e.g. \"-D\" for pseudo tags)."
  (let* ((match     (or match 'exact))
          (extras    (concat "-Ene"
                      (pcase match
                        ('exact "")
                        ('prefix "p")
                        (_ (error "Unexpected MATCH value")))
                      (if case-fold "i" "")))
          (tagsfile  (substring-no-properties tagsfile))
          (name      (when name (substring-no-properties name)))
          (filter    (citre-readtags--strip-text-property-in-list filter))
          (sorter    (citre-readtags--strip-text-property-in-list sorter))
          (cmd       nil)
          (inhibit-message t))  ;; suppress readtags output in echo area
    ;; Program name and base arguments
    (push (or citre-readtags-program "readtags") cmd)
    (push "-t" cmd)
    (push (file-local-name tagsfile) cmd)
    ;; Apply filter and sorter expressions if provided
    (when filter (push "-Q" cmd) (push (format "%S" filter) cmd))
    (when sorter (push "-S" cmd) (push (format "%S" sorter) cmd))
    ;; Extra matching options
    (push extras cmd)
    ;; Name or list all if name is empty
    (if action
      (push action cmd)
      (if (or (null name) (string-empty-p name))
        (push "-l" cmd)            ; list all tags
        (push "-" cmd)               ; search for specific name (stdin)
        (push name cmd)))
    (nreverse cmd)))

(defun consult-citre-readtags--builder (input)
  "Builder function for `consult-citre` that prepares the readtags command.
It returns a cons cell (CMD . HIGHLIGHT), where CMD is the list of process args,
and HIGHLIGHT is a regex (or function) for highlighting matches."
  (pcase-let*
    ;; Split the input into the search term (arg) and any command-line options (opts)
    ((`(,arg . ,opts) (consult--command-split input))
      ;; Compile the search term into regex (for matching) and highlight regexes
      (`(,regexps . ,hl) (funcall consult--regexp-compiler arg 'extended t)))
    ;; Join regexps into a single extended regex (Citre expects one regex for matching)
    (let ((pattern (consult--join-regexps regexps 'extended)))
      (cons
        ;; Build the final command: base readtags command + opts
        (append (consult-citre-readtags--build-cmd
                  (citre-tags-file-path) ; current tags file
                  nil nil t              ; name=nil, match=nil (exact), case-fold=t
                  `((string->regexp ,pattern :case-fold true) $name) ; filter expression
                  nil                    ; sorter
                  (car-safe opts))       ; action (like "-D") if present in opts
          (cdr-safe opts))         ; any extra options (e.g. file name filter)
        hl))))

(defun consult-citre-readtags--format (lines)
  "Format the output LINES from readtags into completion candidates with text properties.
Each candidate string is annotated with a `consult-xref` property (the xref object)
and `consult--prefix-group` property (for grouping by file)."
  (let ((project-root (citre-project-root))
         (tags-info   (citre-readtags-tags-file-info (citre-tags-file-path))))
    (mapcar (lambda (line)
              ;; Parse each line of output into a Citre tag object
              (let* ((tag   (citre-readtags--parse-line line tags-info
                              '(name input pattern line kind) '() '()
                              '(ext-abspath ext-kind-full) '() '() t))
                      (xref  (citre-xref--make-object tag))               ; create an xref item from tag
                      (loc   (xref-item-location xref))
                      ;; Determine group name (usually file path or context for grouping)
                      (group (if (fboundp 'xref--group-name-for-display)
                               (xref--group-name-for-display (xref-location-group loc) project-root)
                               (xref-location-group loc)))
                      ;; Format as "FILE:LINE: MATCH_TEXT" using Consult’s helper
                      (cand  (consult--format-file-line-match
                               group
                               (or (xref-location-line loc) 0)
                               (xref-item-summary xref))))
                ;; Attach text properties for Consult preview/export:
                ;; - `consult-xref` holds the xref object (used by consult-xref for jumping)
                ;; - `consult--prefix-group` holds the group (for grouping by file in the UI)
                (add-text-properties 0 1 `(consult-xref ,xref
                                            consult--prefix-group ,group)
                  cand)
                cand))
      lines)))

;;;###autoload
(defun consult-citre (&optional initial)
  "Interactively search tags using Citre and jump to the selected tag (with Consult UI).
With a prefix argument, initialize the input with the symbol at point."
  (interactive "P")
  ;; Determine initial input: if non-string (e.g. prefix arg), use symbol at point.
  (let* ((initial-input (if (and initial (not (stringp initial)))
                          (or (thing-at-point 'symbol) "")
                          initial))
          ;; Define the asynchronous candidates source using Consult's new API:
          (candidates (consult--process-collection #'consult-citre-readtags--builder
                        :transform (consult--async-transform #'consult-citre-readtags--format)
                        :highlight t))
          ;; Hook into consult-xref for Embark/export: provide a function to fetch all xrefs
          (consult-xref--fetcher
           (lambda ()
             (mapcar (apply-partially #'get-text-property 0 'consult-xref)
               (funcall candidates nil)))))
    ;; Use `consult--read` to prompt and handle selection, with Consult’s async & preview support
    (xref-pop-to-location                ; jump to the location of the selected xref
      (consult--read
       candidates
       :prompt       "Tag: "
       :initial      initial-input
       :require-match t
       :category     'consult-xref        ; treat candidates as xref items (for default actions)
       :keymap       consult-async-map    ; enable keys for async commands (like live preview toggle)
       :group        #'consult--prefix-group    ; group results by the file (prefix group)
       :state        (consult-xref--preview #'switch-to-buffer)  ; live preview in other window
       :lookup       (apply-partially #'consult--lookup-prop 'consult-xref)))))

(provide 'consult-citre)
