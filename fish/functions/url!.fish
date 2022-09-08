function url! -w url -d 'Opens any URLs in the input stream'
  while IFS= read line;
    for url in (echo $line | url)
      open $url
    end
  end
end
