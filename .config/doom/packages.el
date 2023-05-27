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

;; [[file:config.org::*modus][modus:1]]
(package! modus-themes :recipe (:host github :repo "protesilaos/modus-themes"))
;; modus:1 ends here



;; https://github.com/hlissner/doom-emacs/issues/4498



;; [[file:config.org::*profiling code][profiling code:1]]
(package! benchmark-init)
;; profiling code:1 ends here

;; [[file:config.org::*debugging][debugging:1]]
(package! bug-hunter)
;; debugging:1 ends here



;; [[file:~/.emacs.d/lisp/packages.el][file:~/.emacs.d/lisp/packages.el]] see Pinned package versions


;; [[file:config.org::*Disabled/unpinned packages][Disabled/unpinned packages:1]]
;; magit-todos: was slow on the startup, unused
(disable-packages! magit-todos)
(disable-packages! which-key)
(disable-packages! dired-git-info)


;; updates to a version that has org-store-link compatibility instead of 6633d82c6e3c921c486ec284cb6542f33278b605
(unpin! helpful)
;; Disabled/unpinned packages:1 ends here

;; [[file:config.org::*persistent scratch][persistent scratch:1]]
(package! persistent-scratch)
;; persistent scratch:1 ends here

;; [[file:config.org::*Eval][Eval:1]]
(package! pp+ :recipe (:host github :repo "emacsmirror/pp-plus"))
;; Eval:1 ends here

;; [[file:config.org::*(Disable) Mouse][(Disable) Mouse:1]]
(package! disable-mouse)
;; (Disable) Mouse:1 ends here



;; https://dzone.com/articles/rare-letter-combinations-and


;; #+begin_example
;; ❯ curl -Ov https://www.johndcook.com/unordered_bigram_frequencies.csv
;; ❯ rg --pcre2 '^([A-Z])\1' unordered_bigram_frequencies.csv
;; 29:JJ,0
;; 43:KK,0
;; 69:QQ,0
;; 90:VV,0
;; 96:WW,0
;; 111:YY,0
;; 135:HH,0.001
;; 154:UU,0.001
;; 197:AA,0.003
;; 212:XX,0.003
;; 215:ZZ,0.003
;; 274:BB,0.011
;; 299:II,0.023
;; 302:GG,0.025
;; 331:DD,0.043
;; 378:NN,0.073
;; 383:CC,0.083
;; 400:MM,0.096
;; 421:RR,0.121
;; 426:PP,0.137
;; 431:FF,0.146
;; 442:TT,0.171
;; 457:OO,0.21
;; 526:EE,0.378
;; 535:SS,0.405
;; 572:LL,0.577
;; #+end_example



;; [[file:config.org::*Chords][Chords:1]]
(package! key-chord)
;; Chords:1 ends here



;; +Leads to all kinds of hell -- errors everywhere. unclear what this is conflicting with.
;; +https://github.com/mina86/auto-dim-other-buffers.el/issues/32+


;; [[file:config.org::*dim other buffers][dim other buffers:1]]
(package! auto-dim-other-buffers)
;; dim other buffers:1 ends here


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

;; [[file:config.org::*pulsar][pulsar:1]]
(package! pulsar)
;; pulsar:1 ends here

;; [[file:config.org::*highlights][highlights:1]]
(package! goggles :recipe (:host github :repo "minad/goggles"))
;; highlights:1 ends here

;; [[file:config.org::*wrap region][wrap region:1]]
(package! wrap-region)
;; wrap region:1 ends here


;; https://xenodium.com/modern-elisp-libraries/

;; TODO: Look into seq, map, cl- instead of dash/ht



;; [[file:config.org::*Libraries][Libraries:1]]
(package! dash)
(package! s)
(package! f)
(package! ht)
(package! ts)
;; Libraries:1 ends here

;; [[file:config.org::*Find file - mark readonly][Find file - mark readonly:1]]
(package! hardhat :recipe (:host github :repo "rolandwalker/hardhat"))
;; Find file - mark readonly:1 ends here

;; [[file:config.org::*minor modes][minor modes:1]]
(package! minions)
;; minor modes:1 ends here

;; [[file:config.org::*mode minder][mode minder:1]]
(package! mode-minder :recipe (:host github :repo "jdtsmith/mode-minder"))
;; mode minder:1 ends here

;; [[file:config.org::*Movement][Movement:1]]
(package! windmove)
;; Movement:1 ends here

;; [[file:config.org::*Restore][Restore:1]]
(package! winner)
;; Restore:1 ends here

;; [[file:config.org::*bufler][bufler:1]]
(package! bufler)
;; bufler:1 ends here




;; https://github.com/karthink/popper/issues/38

;; [[file:config.org::*Popups][Popups:1]]
(package! popper :recipe (:host github :repo "karthink/popper" :branch "local-mode-line-format"))
;; Popups:1 ends here

;; [[file:config.org::*Popups][Popups:2]]
;; (package! popper )
;; Popups:2 ends here

;; [[file:config.org::*Adjust for display size change][Adjust for display size change:1]]
(package! dispwatch :recipe (:host github :repo "mnp/dispwatch"))
;; Adjust for display size change:1 ends here

;; [[file:config.org::*Kill/Yank/Mark regions][Kill/Yank/Mark regions:1]]
;; (package! hungry-delete)
;; Kill/Yank/Mark regions:1 ends here

;; [[file:config.org::*visible mark][visible mark:1]]
(package! visible-mark)
;; visible mark:1 ends here

;; [[file:config.org::*expand region][expand region:1]]
(package! expand-region)
;; expand region:1 ends here

;; [[file:config.org::*easy-kill base][easy-kill base:1]]
(package! easy-kill :recipe (:host github :repo "leoliu/easy-kill"))
;; easy-kill base:1 ends here

;; [[file:config.org::*easy-kill-extras][easy-kill-extras:1]]
(package! easy-kill-extras)
(package! multiple-cursors)
;; easy-kill-extras:1 ends here


;; https://github.com/NicholasBHubbard/clean-kill-ring.el


;; [[file:config.org::*clean-kill-ring][clean-kill-ring:1]]
(package! clean-kill-ring :recipe (:host github :repo "NicholasBHubbard/clean-kill-ring.el"))
;; clean-kill-ring:1 ends here

;; [[file:config.org::*move-text][move-text:1]]
(package! move-text)
;; move-text:1 ends here

;; [[file:config.org::*vundo][vundo:1]]
(package! vundo :recipe (:host github :repo "casouri/vundo"))
;; vundo:1 ends here

;; [[file:config.org::*Last change][Last change:1]]
(package! goto-chg :recipe (:host github :repo "emacs-evil/goto-chg"))
;; Last change:1 ends here

;; [[file:config.org::*point][point:1]]
(package! point-undo :recipe (:host github :repo "emacsmirror/point-undo"))
;; point:1 ends here

;; [[file:config.org::*Snippets][Snippets:1]]
(package! yankpad :recipe (:host github :repo "Kungsgeten/yankpad"))
(package! yasnippet)
;; Snippets:1 ends here

;; [[file:config.org::*unfill paragraphs][unfill paragraphs:1]]
(package! unfill)
;; unfill paragraphs:1 ends here

;; [[file:config.org::*Boxing][Boxing:1]]
(package! rebox2)
;; Boxing:1 ends here

;; [[file:config.org::*separedit][separedit:1]]
(package! separedit)
;; separedit:1 ends here



;; Doom emacs's version :ui indent-guides sets up hooks for org-mode which interact badly with org-indent-modern


;; [[file:config.org::*Guides][Guides:1]]
(package! highlight-indent-guides)
;; Guides:1 ends here

;; [[file:config.org::*Movement][Movement:1]]
(package! mwim)
;; Movement:1 ends here

;; [[file:config.org::*smartscan][smartscan:1]]
(package! smartscan)
;; smartscan:1 ends here

;; [[file:config.org::*regex-based searching, using python/pcre][regex-based searching, using python/pcre:1]]
(package! visual-regexp)
(package! visual-regexp-steroids)
;; regex-based searching, using python/pcre:1 ends here

;; [[file:config.org::*Jumping][Jumping:1]]
(package! smart-jump)
(package! rg)                           ;For smart-jump-find-references-with-rg
;; Jumping:1 ends here



;; https://github.com/doomemacs/doomemacs/issues/1213

;; We put this file directly in .config/doom/lisp (.doom.d) so that we can edit locally, and added to yadm


;; [[file:config.org::*vicb][vicb:1]]
;; (package! vi-consult-buffers :recipe (:host github :repo "indigoviolet/vi-consult-buffers"))
;; vicb:1 ends here



;; +This is not very useful in practice:+ doom has built in support for project
;; switching that works better with workspaces; but we can use just the find-file
;; function, which is better than +doom-project-find-file


;; [[file:config.org::*consult-projectile][consult-projectile:1]]
(package! consult-projectile :recipe (:host gitlab :repo "OlMon/consult-projectile"))
;; consult-projectile:1 ends here

;; [[file:config.org::*Narrowing][Narrowing:1]]
(package! recursive-narrow)
;; Narrowing:1 ends here



;; - clutters in prog-mode, but probably useful in ein:notebook-mode


;; [[file:config.org::*outline faces][outline faces:1]]
(package! outline-minor-faces :recipe (:host github :repo "tarsius/outline-minor-faces"))
;; outline faces:1 ends here

;; [[file:config.org::*Tabnine][Tabnine:1]]
(package! company-tabnine)
;; Tabnine:1 ends here

;; [[file:config.org::*Corfu/Cape][Corfu/Cape:1]]
(package! corfu :recipe (:host github :repo "minad/corfu" :files (:defaults "extensions/*.el")))
(package! cape)
(package! popon :recipe (:type git :repo "https://codeberg.org/akib/emacs-popon.git"))
;; (package! corfu-terminal :recipe (:type git :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))
;; Corfu/Cape:1 ends here

;; [[file:config.org::*original package][original package:1]]
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))
;; original package:1 ends here

;; [[file:config.org::*chatgpt shell][chatgpt shell:1]]
(package! chatgpt-shell)
;; chatgpt shell:1 ends here

;; [[file:config.org::*Iedit][Iedit:1]]
(package! iedit)
;; Iedit:1 ends here

;; [[file:config.org::*wgrep][wgrep:1]]
(package! wgrep)
;; wgrep:1 ends here

;; [[file:config.org::*Hydra][Hydra:1]]
(package! pretty-hydra)
(package! major-mode-hydra)
;; Hydra:1 ends here

;; [[file:config.org::*org-mode package][org-mode package:1]]
;; Pinning for unfolding org-mode overlays while searching
;; https://github.com/doomemacs/doomemacs/issues/6478#issuecomment-1293505404
(package! org :pin "971eb6885ec996c923e955730df3bafbdc244e54")
;; (package! org :pin "6001313b8f8bc2c717b44070d6e7b19afc6125ec")
;; org-mode package:1 ends here

;; [[file:config.org::*show delimiters][show delimiters:1]]
(package! org-appear :recipe (:host github :repo "awth13/org-appear"))
;; show delimiters:1 ends here



;; +Fails with /sudo tangle files https://github.com/yilkalargaw/org-auto-tangle/issues/9+

;; Fails with `:comments both` and certain modes:
;; https://github.com/yilkalargaw/org-auto-tangle/issues/11, but so does "Custom
;; async tangle" below.

;; The "After save hook" version is synchronous and has no problems.

;; +<2022-07-08 Fri> Pinned to c208036 to see if 'max-lisp-eval-depth' errors were caused by https://github.com/yilkalargaw/org-auto-tangle/commit/5b6071c5649ed648c97cd2deebf74fe633f7f0d0+

;; Also see https://tecosaur.github.io/emacs-config/config.html#asynchronous-config-tangling

;; We'd like to set a timeout and fall through to synchronous tangle?


;; [[file:config.org::*Use auto-tangle][Use auto-tangle:1]]
(package! org-auto-tangle :recipe (:host github :repo "yilkalargaw/org-auto-tangle"))
;; Use auto-tangle:1 ends here

;; [[file:config.org::*Images][Images:1]]
(package! org-download)
;; Images:1 ends here

;; [[file:config.org::*Import from various formats into org][Import from various formats into org:1]]
(package! org-pandoc-import :recipe (:host github :repo "tecosaur/org-pandoc-import" :files ("*.el" "filters" "preprocessors")))
;; Import from various formats into org:1 ends here

;; [[file:config.org::*literate calc][literate calc:1]]
(package! literate-calc-mode)
;; literate calc:1 ends here

;; [[file:config.org::*table of contents][table of contents:1]]
(package! org-make-toc)
;; table of contents:1 ends here



;; Alternative: https://github.com/jgru/consult-org-roam


;; [[file:config.org::*consult-notes][consult-notes:1]]
(package! consult-notes :recipe (:host github :repo "mclear-tools/consult-notes"))
;; consult-notes:1 ends here

;; [[file:config.org::*colored-text][colored-text:1]]
(package! org-colored-text :recipe (:host github :repo "indigoviolet/org-colored-text"))
;; colored-text:1 ends here

;; [[file:config.org::*Github flavored Markdown][Github flavored Markdown:1]]
(package! ox-gfm)
;; Github flavored Markdown:1 ends here

;; [[file:config.org::*ein][ein:1]]
;; (package! ein :pin "6063cee")           ;dec 25 2021 - previous working version
(package! ein :pin "87f4448")           ;apr 26 2023
;; ein:1 ends here

;; [[file:config.org::*vterm][vterm:1]]
(unpin! vterm)
;; vterm:1 ends here



;; [[https://github.com/lassik/emacs-format-all-the-code/issues/170#issuecomment-1079740651][See]] for some context on the comparison b/w apheleia and format-all available --
;; these may be merged in the near future. Based on the table there, we are
;; choosing b/w format-all (more formatters, synchronous, chaining), and apheleia
;; (fewer but maybe the ones we need, async, chaining).

;; In addition, there is doom-emacs' adaptation of format-all, which is [[https://github.com/hlissner/doom-emacs/issues/6203][old]], [[https://github.com/hlissner/doom-emacs/issues/4526][due
;; for a rewrite for a long while]], does not support multiple formatters. Calling
;; set-formatter! can silently break the chain (?)



;; [[file:config.org::*Code Formatting][Code Formatting:1]]
(package! py-isort :disable t)
;; Code Formatting:1 ends here

;; [[file:config.org::*apheleia][apheleia:1]]
(package! apheleia)
;; apheleia:1 ends here



;; For ein notebooks. this requires black-macchiato via pipx


;; [[file:config.org::*python-black][python-black:1]]
(package! python-black)
;; python-black:1 ends here

;; [[file:config.org::*Javascript/Typescript][Javascript/Typescript:1]]
(package! add-node-modules-path :recipe (:host github :repo "codesuki/add-node-modules-path"))
;; Javascript/Typescript:1 ends here

;; [[file:config.org::*dirvish][dirvish:1]]
(package! dirvish)
;; dirvish:1 ends here

;; [[file:config.org::*dired git info/log][dired git info/log:1]]
(package! dired-git-log :recipe (:host github :repo "amno1/dired-git-log"))
;; dired git info/log:1 ends here

;; [[file:config.org::*sidebar][sidebar:1]]
(package! dired-sidebar)
;; sidebar:1 ends here

;; [[file:config.org::*all the icons][all the icons:1]]
(package! all-the-icons-dired)
;; all the icons:1 ends here

;; [[file:config.org::*sudo][sudo:1]]
(package! dired-togle-sudo :recipe (:host github :repo "renard/dired-toggle-sudo"))
;; sudo:1 ends here



;; Execute commands on save
;; https://github.com/emacsmirror/firestarter


;; [[file:config.org::*Firestarter][Firestarter:1]]
(package! firestarter)
;; Firestarter:1 ends here

;; [[file:config.org::*docker][docker:1]]
(package! dockerfile-mode)
;; docker:1 ends here

;; [[file:config.org::*Misc][Misc:1]]
(package! git-modes)
(package! ssh-config-mode)
(package! jsonnet-mode)
(package! sparql-mode)
;; Misc:1 ends here

;; [[file:config.org::*jsonnet][jsonnet:1]]
(package! jsonnet-mode)
;; jsonnet:1 ends here

;; [[file:config.org::*Just][Just:1]]
(package! just-mode)
(package! justl)
;; Just:1 ends here

;; [[file:config.org::*numbers commas][numbers commas:1]]
(package! commify)
;; numbers commas:1 ends here



;; alternative: https://github.com/karthink/org-auctex



;; [[file:config.org::*latex][latex:1]]
(package! org-latex-impatient)
;; latex:1 ends here

;; [[file:config.org::*atomic chrome][atomic chrome:1]]
(package! atomic-chrome)
;; atomic chrome:1 ends here

;; [[file:config.org::*gif screencast][gif screencast:1]]
(package! gif-screencast :recipe (:host gitlab :repo "ambrevar/emacs-gif-screencast"))
;; gif screencast:1 ends here

;; [[file:config.org::*Keycast][Keycast:1]]
(package! keycast :recipe (:host github :repo "tarsius/keycast"))
;; Keycast:1 ends here

;; [[file:config.org::*PDF][PDF:1]]
(unpin! pdf-tools)
;; PDF:1 ends here

;; [[file:config.org::*pdf tools fork with smooth scrolling][pdf tools fork with smooth scrolling:1]]
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
;; pdf tools fork with smooth scrolling:1 ends here

;; [[file:config.org::*zotxt (zotero + emacs)][zotxt (zotero + emacs):1]]
(package! zotxt)
;; zotxt (zotero + emacs):1 ends here

;; [[file:config.org::*org-noter][org-noter:1]]
(package! org-noter)
;; org-noter:1 ends here

;; [[file:config.org::*Pomodoro][Pomodoro:1]]
(package! org-pomodoro)
;; Pomodoro:1 ends here

;; [[file:config.org::*detached][detached:1]]
(package! detached)
;; detached:1 ends here

;; [[file:config.org::*dev-docs][dev-docs:1]]
(package! devdocs)
;; dev-docs:1 ends here

;; [[file:config.org::*Keyfreq][Keyfreq:1]]
(package! keyfreq :recipe (:host github :repo "dacap/keyfreq"))
;; Keyfreq:1 ends here
