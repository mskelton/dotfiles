#!/usr/bin/env bats

fn=./bin/url

@test "http" {
  u='http://google.com'
  res=$(echo "My http URL $u is here." | $fn)
  [ "$res" == "$u" ]
}

@test "https" {
  u='https://google.com'
  res=$(echo "My https URL $u is here." | $fn)
  [ "$res" == "$u" ]
}

@test "ftp" {
  u='ftp://ftp.vim.org/pub/vim/README'
  res=$(echo "My ftp URL $u is here." | $fn)
  [ "$res" == "$u" ]
}

@test "path params" {
  u='https://foo.com/bar/baz'
  res=$(echo "My paths $u are here." | $fn)
  [ "$res" == "$u" ]
}

@test "query params" {
  u='https://www.example.com?foo=bar&baz=qux'
  res=$(echo "My query params: $u" | $fn)
  [ "$res" == "$u" ]
}

@test "localhost" {
  u='http://localhost'
  res=$(echo "This is my url $u." | $fn)
  [ "$res" == "$u" ]
}

@test "localhost with port" {
  u='http://localhost:3000'
  res=$(echo "This is my url $u." | $fn)
  [ "$res" == "$u" ]
}

@test "url with port" {
  u='http://google.com:3000/mark'
  res=$(echo "This is my url $u." | $fn)
  [ "$res" == "$u" ]
}

@test "markdown" {
  u='https://google.com?foo=bar'
  res=$(echo "This is [my link]($u)." | $fn)
  [ "$res" == "$u" ]
}

@test "hyphens" {
  u='https://devblogs.microsoft.com/typescript/announcing-typescript-5-0-beta/'
  res=$(echo "Description $u" | $fn)
  [ "$res" == "$u" ]
}

@test "file extension" {
  u="http://google.com/index.js"
  res=$(echo "Description $u" | $fn)
  [ "$res" == "$u" ]
}

@test "spaces" {
  u='http://google.com/foo+bar/spam%20eggs?foo=bar+baz&green=spam%20eggs'
  res=$(echo "Description $u" | $fn)
  [ "$res" == "$u" ]
}

@test "periods in query params" {
  u='https://google.com?foo=bar.baz'
  res=$(echo "Description $u" | $fn)
  [ "$res" == "$u" ]
}
