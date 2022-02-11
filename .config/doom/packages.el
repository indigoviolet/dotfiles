;; packages.el

;; [[file:config.org::*packages.el][packages.el:1]]
;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; DO NOT EDIT THIS FILE DIRECTLY

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
;; packages.el:1 ends here

;; Disabled packages

;; magit-todos: was slow on the startup, unused


;; [[file:config.org::*Disabled packages][Disabled packages:1]]
(disable-packages! magit-todos)
;; Disabled packages:1 ends here

;; Chords


;; [[file:config.org::*Chords][Chords:1]]
(package! use-package-chords)
;; Chords:1 ends here

;; Rainbow
;; :LOGBOOK:
;; - State "KILL"       from "DONE"       [2022-01-26 Wed 17:28]
;; - State "DONE"       from "WAIT"       [2022-01-26 Wed 17:28]
;; - State "WAIT"       from "TODO"       [2022-01-26 Wed 17:28]
;; - State "KILL"       from "DONE"       [2022-01-26 Wed 17:28]
;; - State "DONE"       from "WAIT"       [2022-01-26 Wed 17:28]
;; - State "WAIT"       from "TODO"       [2022-01-26 Wed 17:28]
;; :END:


;; [[file:config.org::*Rainbow][Rainbow:1]]
(package! rainbow-mode)
(package! rainbow-delimiters)
(package! rainbow-identifiers)
;; Rainbow:1 ends here

;; Environment



;; [[file:config.org::*Environment][Environment:1]]
(package! exec-path-from-shell)
;; Environment:1 ends here

;; Movement



;; [[file:config.org::*Movement][Movement:1]]
(package! windmove)
;; Movement:1 ends here

;; Restore


;; [[file:config.org::*Restore][Restore:1]]
(package! winner)
;; Restore:1 ends here

;; zoom



;; [[file:config.org::*zoom][zoom:1]]
(package! zoom :recipe (:host github :repo "cyrus-and/zoom"))
;; zoom:1 ends here

;; bufler



;; [[file:config.org::*bufler][bufler:1]]
(package! bufler)
;; bufler:1 ends here

;; [[file:config.org::*Adjust for display change][Adjust for display change:2]]
(package! dispwatch :recipe (:host github :repo "mnp/dispwatch"))
;; Adjust for display change:2 ends here

;; Kill/Yank


;; [[file:config.org::*Kill/Yank][Kill/Yank:1]]
(package! hungry-delete)
(package! easy-kill :recipe (:host github :repo "leoliu/easy-kill"))
(package! easy-kill-extras)
;; Kill/Yank:1 ends here

;; Yankpad


;; [[file:config.org::*Yankpad][Yankpad:1]]
(package! yankpad :recipe (:host github :repo "Kungsgeten/yankpad"))
(package! yasnippet)
;; Yankpad:1 ends here

;; Fill



;; [[file:config.org::*Fill][Fill:1]]
(package! unfill)
(package! fill-function-arguments)
;; Fill:1 ends here

;; Comment editing



;; [[file:config.org::*Comment editing][Comment editing:1]]
(package! rebox2)
(package! poporg)
;; Comment editing:1 ends here

;; Movement



;; [[file:config.org::*Movement][Movement:1]]
(package! mwim)
;; Movement:1 ends here

;; Search/Filtering



;; [[file:config.org::*Search/Filtering][Search/Filtering:1]]
(package! smartscan)
(package! ctrlf)
;; Search/Filtering:1 ends here

;; regex-based searching, using python/pcre




;; [[file:config.org::*regex-based searching, using python/pcre][regex-based searching, using python/pcre:1]]
(package! visual-regexp)
(package! visual-regexp-steroids)
;; regex-based searching, using python/pcre:1 ends here

;; Jumping



;; [[file:config.org::*Jumping][Jumping:1]]
(package! smart-jump)
(package! rg)                           ;For smart-jump-find-references-with-rg
;; Jumping:1 ends here

;; Narrowing



;; [[file:config.org::*Narrowing][Narrowing:1]]
(package! recursive-narrow)
;; Narrowing:1 ends here

;; Prescient


;; [[file:config.org::*Prescient][Prescient:1]]
(package! company-prescient)
;; Prescient:1 ends here

;; Tabnine



;; [[file:config.org::*Tabnine][Tabnine:1]]
(package! company-tabnine)
;; Tabnine:1 ends here

;; Iedit


;; [[file:config.org::*Iedit][Iedit:1]]
(package! iedit)
;; Iedit:1 ends here

;; wgrep


;; [[file:config.org::*wgrep][wgrep:1]]
(package! wgrep)
;; wgrep:1 ends here

;; show delimiters


;; [[file:config.org::*show delimiters][show delimiters:1]]
(package! org-appear :recipe (:host github :repo "awth13/org-appear"))
;; show delimiters:1 ends here

;; Images



;; [[file:config.org::*Images][Images:1]]
(package! org-download)
;; Images:1 ends here

;; Import from various formats into org



;; [[file:config.org::*Import from various formats into org][Import from various formats into org:1]]
(package! org-pandoc-import   :recipe (:host github :repo "tecosaur/org-pandoc-import" :files ("*.el" "filters" "preprocessors")))
;; Import from various formats into org:1 ends here

;; literate calc



;; [[file:config.org::*literate calc][literate calc:1]]
(package! literate-calc-mode)
;; literate calc:1 ends here

;; super-agenda



;; [[file:config.org::*super-agenda][super-agenda:1]]
(package! org-super-agenda)
;; super-agenda:1 ends here

;; Firestarter



;; [[file:config.org::*Firestarter][Firestarter:1]]
(package! firestarter)
;; Firestarter:1 ends here

;; ein



;; [[file:config.org::*ein][ein:1]]
(package! ein :pin "f2bad874d325fce4eb06986fa97b2bdb418a11eb")
;; ein:1 ends here

;; vterm


;; [[file:config.org::*vterm][vterm:1]]
(package! multi-vterm :recipe (:host github :repo "suonlight/multi-vterm"))
(package! vterm-toggle :recipe (:host github :repo "jixiuf/vterm-toggle"))
;; vterm:1 ends here

;; flycheck-projectile



;; [[file:config.org::*flycheck-projectile][flycheck-projectile:1]]
(package! flycheck-projectile)
;; flycheck-projectile:1 ends here

;; LSP



;; [[file:config.org::*LSP][LSP:1]]
(package! lsp-treemacs)
;; LSP:1 ends here

;; Python



;; [[file:config.org::*Python][Python:1]]
(package! python-black)
(package! lsp-python-ms :disable t)     ;it will override lsp-pyright otherwise
(package! lsp-pyright)
;; Python:1 ends here

;; Javascript/Typescript


;; [[file:config.org::*Javascript/Typescript][Javascript/Typescript:1]]
(package! add-node-modules-path :recipe (:host github :repo "codesuki/add-node-modules-path"))
;; Javascript/Typescript:1 ends here

;; docker


;; [[file:config.org::*docker][docker:1]]
(package! dockerfile-mode)
;; docker:1 ends here

;; Misc modes


;; [[file:config.org::*Misc modes][Misc modes:1]]
(package! git-modes)
(package! ssh-config-mode)
;; Misc modes:1 ends here

;; atomic chrome




;; [[file:config.org::*atomic chrome][atomic chrome:1]]
(package! atomic-chrome)
;; atomic chrome:1 ends here

;; annotate

;; +OK, but sets the buffer to modified: https://github.com/bastibe/annotate.el/issues/74+


;; [[file:config.org::*annotate][annotate:1]]
;; (package! annotate :recipe (:host github :repo "cage2/annotate.el" :branch "prevent-saving-empty-db"))
(package! annotate :recipe (:host github :repo "bastibe/annotate.el"))
;; annotate:1 ends here

;; Pomodoro



;; [[file:config.org::*Pomodoro][Pomodoro:1]]
(package! org-pomodoro)
;; Pomodoro:1 ends here
