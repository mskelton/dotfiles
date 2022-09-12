function __bm_list_bookmarks
  set bookmarks_path '/Users/mark/Library/Application Support/Google/Chrome/Default/Bookmarks'
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

  cat $bookmarks_path | jq $filter
end

function __bm_filter_bookmarks -a query
  jq -c --arg query $query 'select(.slug | startswith($query))'
end

function bm -a query -d "Open Chrome bookmark"
  # If bm is called without argument, show all bookmarks
  set -q query[1]; or set query ""

  # Filter the bookmarks by the provided query
  set bookmarks (__bm_list_bookmarks | __bm_filter_bookmarks $query)

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
      # Get the exact slug of the bookmark
      set slug (printf %"s\n" $bookmarks | jq -r '.slug' | fzf)

      # Find the bookmark by slug and open the URL in Chrome. If no bookmark is
      # selected from the list, exit with an error.
      if test -n "$slug"
        echo $bookmarks | __bm_filter_bookmarks $slug | jq '.url' | xargs open
      else
        echo 'No bookmark selected, exiting'
        return 1
      end
  end
end
