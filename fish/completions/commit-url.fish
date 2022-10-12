# https://github.com/fish-shell/fish-shell/blob/master/share/completions/git.fish
function __fish_git_commits
  command git log --pretty=tformat:"%H"\t"%<(64,trunc)%s" --all --max-count=1000 \
    | string replace -r '^([0-9a-f]{10})[0-9a-f]*\t(.*)' '$1\t$2'
end

complete -f -c commit-url -ka '(__fish_git_commits)'

