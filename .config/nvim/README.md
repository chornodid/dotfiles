# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Setting up a new machine

1. Install the tools the plugins and Mason need: `git`, `nodejs`, `npm`, `unzip`, `tree-sitter-cli`,
   `lazygit`, `ripgrep`, `fd`, a C compiler, and a global Ruby (for `ruby-lsp`, `erb-formatter`, `erb-lint`).
2. Get the config: `yadm clone git@github.com:chornodid/dotfiles.git`
   (on machines that should only get some dotfiles: `yadm sparse-checkout set --no-cone /.config/nvim/`).
3. Start Neovim once and let it install everything, then quit.
4. Restore the locked plugin versions:

   ```sh
   yadm checkout -- ~/.config/nvim/lazy-lock.json
   nvim --headless "+Lazy! restore" +qa
   ```

   On a fresh install lazy.nvim installs LazyVim's own plugins in a second round, after it has already
   rewritten the lockfile without them, so they come in at their newest versions. `yadm status` should
   show `lazy-lock.json` unchanged afterwards.

## Updating plugins

Update on one machine only (`:Lazy update`), then commit and push `lazy-lock.json`.
On the others: `yadm pull`, then `:Lazy restore`.
