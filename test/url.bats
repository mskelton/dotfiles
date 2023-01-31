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

