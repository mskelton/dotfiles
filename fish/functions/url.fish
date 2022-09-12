function url -d 'Print each URL in the input stream'
  while IFS= read line
    string match -a -r 'https?://\S+' -- $line
  end
end
