{ epkgs, lib, isAndroid, ...}:

with epkgs; [
  # Bootstrap
  use-package
  
  # Performance
  gcmh
  
  # Core Editor
  which-key
  puni
  vundo
  visual-regexp
  avy
  expand-region
  
  # UI/Theme
  ef-themes
  spacious-padding
  dimmer
  nano-modeline
  moody
  minions
  mlscroll
  nerd-icons
  nerd-icons-corfu
  
  # Minibuffer Completion
  vertico
  vertico-posframe
  consult
  consult-dir
  consult-flycheck
  consult-eglot
  embark-consult
  marginalia
  orderless
  embark
  
  # In-Buffer Completion
  corfu
  corfu-terminal
  kind-icon
  cape
  
  # File Manager
  treemacs
  treemacs-nerd-icons
  treemacs-icons-dired
  treemacs-magit
  activities
  diff-hl
  
  # Git
  magit
  difftastic
  
  # Language Support
  (treesit-grammars.with-grammars (p: with p; [
    tree-sitter-bash
    tree-sitter-c
    tree-sitter-c-sharp
    tree-sitter-cmake
    tree-sitter-css
    tree-sitter-scss
    tree-sitter-dockerfile
    tree-sitter-elisp
    tree-sitter-go
    tree-sitter-html
    tree-sitter-javascript
    tree-sitter-json
    tree-sitter-make
    tree-sitter-markdown
    tree-sitter-markdown-inline
    tree-sitter-nix
    tree-sitter-python
    tree-sitter-ruby
    tree-sitter-rust
    tree-sitter-toml
    tree-sitter-tsx
    tree-sitter-typescript
    tree-sitter-yaml
  ]))
  eglot
  aggressive-indent
  reformatter
  
  # Language Modes
  applescript-mode
  clojure-mode
  clojure-ts-mode
  cider
  flycheck-clj-kondo
  dockerfile-mode
  eros
  fish-mode
  go-mode
  lua-mode
  markdown-mode
  edit-indirect
  nix-ts-mode
  rust-mode
  cargo
  
  # Development
  flycheck
  exec-path-from-shell
  
  # Org Mode
  org-bullets
  org-side-tree
  org-modern
  org-appear
  denote
  consult-notes
  olivetti
  
  # Highlight
  rainbow-mode
  rainbow-delimiters
  hl-todo
  
  # Emacs Lisp Development
  macrostep
  elisp-demos
  highlight-defined
  
  # Utility
  ns-auto-titlebar # macOS向けだが、Linuxでもタイトルバー制御に使える場合がある
] ++ lib.optionals (!isAndroid) [
  # Desktop-only packages
  # eglot-booster # ビルドが必要な場合はここに追加
]
