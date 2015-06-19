# Load shell dotfiles
for file in ~/.{path,bash_prompt,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  source $(brew --prefix)/share/bash-completion/bash_completion
fi
