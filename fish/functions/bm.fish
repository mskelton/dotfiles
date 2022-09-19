function __bm_list_bookmarks
  set filter '.roots
    | to_entries[].value
    | recurse(.children[]?)
    | select(.type == "url")
    | {
        name,
        url,
        slug: .name
          | gsub("\'"; "")
          | gsub("[^a-zA-Z0-9]"; "-")
          | gsub("-{2,}"; "-")
          | gsub("(^-|-$)"; "")
          | ascii_downcase
      }'

  cat $BOOKMARKS_PATH | jq $filter
end

function __bm_filter_bookmarks -a key value
  jq -c --arg key $key --arg value $value 'select(.[$key] | startswith($value))'
end

function bm -a slug -d "Open Chrome bookmark"
  # If bm is called without argument, show all bookmarks
  set -q slug[1]; or set slug ""

  # Filter the bookmarks by the provided slug
  set bookmarks (__bm_list_bookmarks | __bm_filter_bookmarks 'slug' $slug)

  switch (count $bookmarks)
    # No bookmark found, exit with error
    case 0
      echo 'No bookmark found matching the provided slug'
      return 1

    # Unique bookmark found, open in Chrome
    case 1
      echo $bookmarks | jq '.url' | xargs open

    # Multiple matching bookmarks found, launch FZF to filter
    case '*'
      # Get the exact name of the bookmark
      set name (printf %"s\n" $bookmarks | jq -r '.name' | fzf --no-info)

      # Find the bookmark by name and open the URL in Chrome. If no bookmark is
      # selected from the list, exit with an error.
      if test -n "$name"
        echo $bookmarks | __bm_filter_bookmarks 'name' $name | jq '.url' | xargs open
      else
        echo 'No bookmark selected, exiting'
        return 1
      end
  end
end
