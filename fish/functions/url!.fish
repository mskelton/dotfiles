function url! -w url -d 'Opens any URLs in the input stream'
  while IFS= read line;
    echo $line | url | xargs open
  end
end
