function url! -w url -d 'Opens any URLs in the input stream'
  while IFS= read line;
    open (echo $line | url)
  end
end
