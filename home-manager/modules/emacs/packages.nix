{ epkgs, lib, isAndroid, ...}:

with epkgs; [
  # --- Bootstrap ---
  use-package
  
  # --- System Integration ---
  envrc
  exec-path-from-shell
  
  # --- Performance ---
  gcmh
  
  # --- Core / Editing ---
  which-key
  puni
  vundo
  visual-regexp
  avy
  expand-region
  ws-butler
  
  # --- UI / Theme ---
  ef-themes
  spacious-padding
  dimmer
  nano-modeline
  moody
  minions
  mlscroll
  nerd-icons
  nerd-icons-corfu
  nerd-icons-dired
  
  # --- Minibuffer / Completion ---
  vertico
  vertico-posframe
  consult
  consult-dir
  consult-flycheck
  consult-eglot
  embark
  embark-consult
  marginalia
  orderless
  wgrep
  
  # --- In-Buffer Completion ---
  corfu
  corfu-terminal
  kind-icon
  cape
  
  # --- File Manager ---
  treemacs
  treemacs-nerd-icons
  treemacs-magit
  dired-hide-dotfiles

  # --- Git ---
  magit
  diff-hl
  
  # --- Programming Support ---
  flycheck
  rainbow-mode
  rainbow-delimiters
  hl-todo
  
  # --- Help System ---
  helpful
  
  # --- Search Enhancement ---
  anzu
  
  # --- Language Support (Tree-sitter) ---
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
  
  # --- LSP ---
  eglot
  
  # --- Language Modes ---
  markdown-mode
  nix-ts-mode
  rust-mode
  go-mode
  lua-mode
  dockerfile-mode
  web-mode
  emmet-mode
  
  # --- Org Mode ---
  org-bullets
  org-modern
  org-appear
  denote
  consult-notes
  olivetti
  htmlize
  
  # --- Elisp Development ---
  macrostep
  elisp-demos
  highlight-defined
  
  # --- Optional: Snippets ---
  # yasnippet
  # yasnippet-snippets
  
  # --- Optional: Auto-format ---
  # apheleia
  
] ++ lib.optionals (!isAndroid) [
  # Desktop only
  pdf-tools
]
