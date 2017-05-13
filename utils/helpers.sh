command_exists() {
  type "$1" &>/dev/null
}

file_exists() {
[ -f "$1" ]
}

backup_if_different() {
  source="$1"
  target="$2"
  local diff=
  if file_exists "$target"; then
    diff=$(colordiff -u "$target" "$source")
    if [ "$(echo "$diff" | wc -l)" -gt 1 ]; then
      printf "Updating %s with the following changes:\n" "$target"
      printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
      printf "\n%s\n\n" "$diff"
      printf "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
      backup_file "$target"
    fi
  fi
}

backup_file() {
  date="$(date "+%Y-%m-%d-%H-%M")"
  mv "${1}" "${1}.backup_${date}"
}

not_empty() {
  [ "$(echo "$1" | wc -l)" -gt 1 ]
}

fancy_echo() {
  printf "\n%s\n\n" "$1"
}

echo_bool() {
  if [ "$1" = true ]; then
    echo "yes"
  else
    echo "no"
  fi
}

echo_h1() {
  printf "\n\n================================================================================\n"
  printf "%s" "$1"
  printf "\n================================================================================\n\n"
}

echo_h2() {
  printf "\n\n--------------------------------------------------------------------------------\n"
  printf "%s" "$1"
  printf "\n--------------------------------------------------------------------------------\n\n"
}

installed() {
  grep -wq "$1" <<< "$installed"
}
