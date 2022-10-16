# Get the list of package.json keys in the current directory so only keys that
# exist are completed.
function __get_package_json_keys
  if test -e package.json
    jq -r 'keys | join("\n")' package.json
  else
    echo ""
  end
end

# Complete the keys in package.json
complete -c pkg -f -n "not __fish_seen_subcommand_from (__get_package_json_keys)" -ka '(__get_package_json_keys)'
