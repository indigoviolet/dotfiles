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

(package! modus-themes :recipe (:host github :repo "protesilaos/modus-themes"))

(package! benchmark-init)

;; magit-todos: was slow on the startup, unused
(disable-packages! magit-todos)
;; (disable-packages! which-key)
(disable-packages! dired-git-info)
(disable-packages! highlight-indent-guides)

;; (package! transient :pin "55d5d41b48d7f7bc1ecf1f90c012d7821dff5724")


;; updates to a version that has org-store-link compatibility instead of 6633d82c6e3c921c486ec284cb6542f33278b605
(unpin! helpful)

;; https://github.com/doomemacs/doomemacs/issues/7244#issuecomment-1643370848
(package! magit :pin "26be78e")
(package! forge :pin "dc4e9ca")

(package! persistent-scratch)

(package! pp+ :recipe (:host github :repo "emacsmirror/pp-plus"))

(package! disable-mouse)

(package! key-chord)

(package! auto-dim-other-buffers)

(package! rainbow-mode)
(package! rainbow-delimiters)
(package! rainbow-identifiers)

(package! pulsar)

(package! goggles :recipe (:host github :repo "minad/goggles"))

(package! diff-hl)

(package! wrap-region)

(package! dash)
(package! s)
(package! f)
(package! ht)
(package! ts)

(package! hardhat :recipe (:host github :repo "rolandwalker/hardhat"))

(package! minions)

(package! mode-minder :recipe (:host github :repo "jdtsmith/mode-minder"))

(package! windmove)

(package! winner)

(package! burly)

(package! bufler)

(package! popper :recipe (:host github :repo "karthink/popper" :branch "local-mode-line-format"))

(package! revbufs :recipe (:host github :repo "joaotavora/revbufs"))

(package! dispwatch :recipe (:host github :repo "mnp/dispwatch"))

;; (package! hungry-delete)

(package! visible-mark)

(package! expand-region)

(package! expreg)

(package! easy-kill :recipe (:host github :repo "leoliu/easy-kill"))

(package! easy-kill-extras)
(package! multiple-cursors)

(package! clean-kill-ring :recipe (:host github :repo "NicholasBHubbard/clean-kill-ring.el"))

(package! move-text)

(package! vundo)

(package! goto-chg :recipe (:host github :repo "emacs-evil/goto-chg"))

(package! point-undo :recipe (:host github :repo "emacsmirror/point-undo"))

(package! undo-hl :recipe (:host github :repo "casouri/undo-hl"))

(package! yankpad :recipe (:host github :repo "Kungsgeten/yankpad"))
(package! yasnippet)

(package! unfill)

(package! rebox2)

(package! separedit)

(package! indent-bars :recipe (:host github :repo "jdtsmith/indent-bars"))

(package! mwim)

(package! smartscan)

(package! visual-regexp)
(package! visual-regexp-steroids)

(package! smart-jump)
(package! rg)                           ;For smart-jump-find-references-with-rg

(package! citre)

(package! gxref)

(package! consult-project-extra)

(package! avy)

(package! imenu-list)

(package! recursive-narrow)

(package! treesit-fold :recipe (:host github :repo "emacs-tree-sitter/treesit-fold"))

(package! corfu :recipe (:host github :repo "minad/corfu" :files (:defaults "extensions/*.el")))
(package! cape)
(package! company)                      ; for company-yankpad
(package! popon :recipe (:host codeberg :repo "akib/emacs-popon"))
;; (package! corfu-terminal :recipe (:type git :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(package! gptel)

(package! iedit)

(package! wgrep)

(package! pretty-hydra)
(package! major-mode-hydra)

(package! hercules :recipe (:host github :repo "cyruseuros/hercules"))

;; Pinning for unfolding org-mode overlays while searching
;; https://github.com/doomemacs/doomemacs/issues/6478#issuecomment-1293505404
(package! org :pin "971eb6885ec996c923e955730df3bafbdc244e54")
;; (package! org :pin "6001313b8f8bc2c717b44070d6e7b19afc6125ec")

(package! org-appear :recipe (:host github :repo "awth13/org-appear"))

(package! org-download)

(package! org-pandoc-import :recipe (:host github :repo "tecosaur/org-pandoc-import" :files ("*.el" "filters" "preprocessors")))

(package! literate-calc-mode)

(package! org-make-toc)

(package! consult-org-roam :recipe (:host github :repo "jgru/consult-org-roam"))

(package! org-colored-text :recipe (:host github :repo "indigoviolet/org-colored-text"))

(package! ox-gfm)

(unpin! vterm)

(package! sticky-shell)

(package! browse-at-remote :recipe (:host github :repo "rmuslimov/browse-at-remote"))

(package! git-link)

(package! ts-movement :recipe (:host github :repo "indigoviolet/ts-movement"))

(package! treesit-auto)

(package! py-isort :disable t)

(package! apheleia)

(package! add-node-modules-path :recipe (:host github :repo "codesuki/add-node-modules-path"))

(package! dirvish)

(package! dired-git-log :recipe (:host github :repo "amno1/dired-git-log"))

(package! all-the-icons-dired)

(package! dired-togle-sudo :recipe (:host github :repo "renard/dired-toggle-sudo"))

(package! firestarter)

(package! dockerfile-mode)

(package! git-modes)
(package! ssh-config-mode)
(package! jsonnet-mode)
;; (package! sparql-mode)
(package! jinja2-mode)

(package! jsonnet-mode)

(package! just-mode)
(package! justl)

(package! commify)

(package! org-latex-impatient)

;; (package! prodigy)

(package! gif-screencast :recipe (:host gitlab :repo "ambrevar/emacs-gif-screencast"))

(package! keycast :recipe (:host github :repo "tarsius/keycast"))

(unpin! pdf-tools)

(package! pdf-tools :recipe
          (:host github
                 :repo "dalanicolai/pdf-tools"
                 :branch "pdf-roll"
                 :files ("lisp/*.el"
                         "README"
                         ("build" "Makefile")
                         ("build" "server")
                         (:exclude "lisp/tablist.el" "lisp/tablist-filter.el"))))

(package! image-roll :recipe
          (:host github
                 :repo "dalanicolai/image-roll.el"))

(package! org-noter)

(package! keyfreq :recipe (:host github :repo "dacap/keyfreq"))
