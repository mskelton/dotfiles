function commit-url! -w commit-url -d 'Copy the GitHub URL of a commit'
  commit-url $argv | pbcopy
end
