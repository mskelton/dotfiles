function update-tag --description 'Update tag for GitHub Action'
  set -l latest_tag (git tag -l --sort -version:refname | head -n 1)
  set -l tag (printf %.2s $latest_tag)

  git tag -fa $tag -m "Update $tag tag"
  git push origin $tag --force
end
