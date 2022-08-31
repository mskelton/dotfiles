function commit-url --description 'Print the GitHub URL of a commit'
  set commit $argv[1]
  if test -z $commit
    set commit (git rev-parse --short HEAD)
  end

  # take the git@hostname.com:account/repo.git format and turn it into https://hostname.com/account/repo/commit/.....
  set base_url (git config --get remote.origin.url)
  set base_url (string replace -r '\.git$' '' $base_url)
  set base_url (string replace -a ':' '/' $base_url)
  set base_url (string replace -r '^git@' 'https://' $base_url)

  echo "$base_url/commit/$commit"
end

function commit-url! --description 'Copy the GitHub URL of a commit'
  commit-url $args | pbcopy
end
