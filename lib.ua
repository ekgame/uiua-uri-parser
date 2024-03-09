# Experimental!
Error ↚ 0⍤:0

UriRegex ↚ $ ^(?P<schema>[\\w\\d\\.\\-]+):(?://(?:(?P<user>[\\w\\d\\.\\-\_]+(?::[\\w\\d\\.\\-\_]+)?)@)?(?:(?P<domain>(?:[\\+\\d\\w\\.\\-]+|\\[[\\w\\d:]+\\]+))(?::(?P<port>\\d+))?)?)?(?P<path>/?(?:[\\w\\d~\\-\\.\_%;,/+@\\+]+)?)?(?:\\?(?P<query>[\\w\\d~\\-\\.\_%;,/+=@\\+\\[\\]&]+))?(?:\\#(?P<fragment>[\\w\\d~\\-\\.\_%;,/+=@\\+]+))?$
ParseFail ↚ $ Could not pase URI: _
ApplyUriRegex ↚ (0|⊡0)⧻.⬚(□"") regex UriRegex
Assign ↚ λ(insert □b ⊡ad c d)

Parse ← (
  .ApplyUriRegex.
  ⍥(Error ParseFail :)≍0
  ⊙◌
  {}
  Assign 1 "schema"
  Assign 2 "user"
  Assign 3 "domain"
  Assign 4 "port"
  Assign 5 "path"
  Assign 6 "query"
  Assign 7 "fragment"
  ◌:
)

---
Fail ← $ Validation failed for: _ 
TestParse ← ⍤Fail⊙≍⟜Parse
TestData ← map {"schema" "user" "domain" "port" "path" "query" "fragment"}

TestData {"ftp" "username:password" "ftp.example.com" "21" "/path/to/file" "key=value&key2[]=value2" "fragment-test"}
TestParse "ftp://username:password@ftp.example.com:21/path/to/file?key=value&key2[]=value2#fragment-test"

TestData {"https" "" "www.google.com" "" "/search" "q=hello" "top"}
TestParse "https://www.google.com/search?q=hello#top"

TestData {"ftp" "username:password" "ftp.example.com" "21" "/path/to/file" "" ""}
TestParse "ftp://username:password@ftp.example.com:21/path/to/file"

TestData {"mailto" "" "" "" "user@example.com" "" ""}
TestParse "mailto:user@example.com"

TestData {"file" "" "" "" "/path/to/file.txt" "" ""}
TestParse "file:///path/to/file.txt"

TestData {"https" "user" "192.168.0.1" "" "" "" ""}
TestParse "https://user@192.168.0.1"

TestData {"https" "" "[2001:db8::1]" "" "/path" "" ""}
TestParse "https://[2001:db8::1]/path"

TestData {"data" "" "" "" "text/plain;base64,SGVsbG8sIFdvcmxkIQ%3D%3D" "" ""}
TestParse "data:text/plain;base64,SGVsbG8sIFdvcmxkIQ%3D%3D"
---

Take ↚ °□get⊙,
IsNotEmpty ↚ λ((0|>0⧻ Take a)has a c b c)

Build ← (
  ""
  ⊂ $"_:" Take "schema"
  ⍥(
    ⊂:"//"
    ⍥(⊂:$"_@" Take "user") IsNotEmpty "user"
    ⊂: Take "domain"
    ⍥(⊂:$":_" Take "port") IsNotEmpty "port"
  ) IsNotEmpty "domain"
  ⍥(⊂: Take "path") IsNotEmpty "path"
  ⍥(⊂: $"?_" Take "query") IsNotEmpty "query"
  ⍥(⊂: $"#_" Take "fragment") IsNotEmpty "fragment"
  ◌:
)