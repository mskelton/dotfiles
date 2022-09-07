function commit-url -a commit -d 'Print the GitHub URL of a commit'
  # Default to the latest commit if no commit was provided
  test -z $commit; and set commit (git rev-parse --short HEAD)

  # Read the repo base URL from the git config
  set base_url (git config --get remote.origin.url)

  # take the git@hostname.com:account/repo.git format and turn it into
  # https://hostname.com/account/repo/commit/.....
  if test -z (string match -r "^https://" $base_url)
    set base_url (string replace -r '\.git$' '' $base_url)
    set base_url (string replace -a ':' '/' $base_url)
    set base_url (string replace -r '^git@' 'https://' $base_url)
  end

  echo "$base_url/commit/$commit"
end

