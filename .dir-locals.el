;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((magit-status-mode . (
                        (eval . (magit-disable-section-inserter 'magit-insert-ignored-files))
                        (magit-todos-exclude-globs . ("*"))
                        )
   ))
