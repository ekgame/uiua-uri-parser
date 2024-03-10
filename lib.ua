# Experimental!
Error ↚ 0⍤:0

UriRegex ↚ $ ^(?P<schema>[\w\d\.\-]+):(?://(?:(?P<user>[\w\d\.\-_]+(?::[\w\d\.\-_]+)?)@)?(?:(?P<domain>(?:[\+\d\w\.\-]+|\[[\w\d:]+\]+))(?::(?P<port>\d+))?)?)?(?P<path>/?(?:[\w\d~\-\._%;,/+@\+]+)?)?(?:\?(?P<query>[\w\d~\-\._%;,/+=@\+\[\]&]+))?(?:\#(?P<fragment>[\w\d~\-\._%;,/+=@\+]+))?$
ParseFail ↚ $$ Could not parse URI: _
ApplyUriRegex ↚ ⟨0|⊡0⟩⧻.⬚(□"") regex UriRegex
Assign ↚ λ(insert □b ⊡ad c d)

Parse ← (
  .ApplyUriRegex.
  ⍥(Error ParseFail :)≍0
  ⊙◌
  {}
  Assign 1 "schema"
  Assign 2 "userinfo"
  Assign 3 "domain"
  Assign 4 "port"
  Assign 5 "path"
  Assign 6 "query"
  Assign 7 "fragment"
  ◌:
)

Take ↚ °□get
IsEmpty ↚ ⟨1◌◌|=0⧻°□get⟩has,,
GetOrEmpty ↚ ⟨""◌◌|°□get⟩has,,
ShouldAddEmptyDomain ↚ /↧[⊃(⊢=@/⊂:" "GetOrEmpty "path")(IsEmpty "domain")]

Build ← (
  ""
  ⊂ $"_:" Take "schema",
  ⍥(
    ⊂:"//"
    ⍥(⊂:$"_@" Take "userinfo",) ¬IsEmpty "userinfo",
    ⊂: Take "domain",
    ⍥(⊂:$":_" Take "port",) ¬IsEmpty "port",
  ) ¬IsEmpty "domain",
  ⍥(⊂:"//") ShouldAddEmptyDomain,
  ⍥(⊂: Take "path",) ¬IsEmpty "path",
  ⍥(⊂: $"?_" Take "query",) ¬IsEmpty "query",
  ⍥(⊂: $"#_" Take "fragment",) ¬IsEmpty "fragment",
  ◌:
)

---
Fail ← $$ Validation failed for: _ 

# Parse each URI and build it again from the parsed data
# The test passes if the original URI and the built URI are equal
TestParseAndBuild ← ⍤ Fail :≍ Build Parse ..

TestParseAndBuild "ftp://username:password@ftp.example.com:21/path/to/file?key=value&key2[]=value2#fragment-test"
TestParseAndBuild "https://www.google.com/search?q=hello#top"
TestParseAndBuild "ftp://username:password@ftp.example.com:21/path/to/file"
TestParseAndBuild "mailto:user@example.com"
TestParseAndBuild "file:///path/to/file.txt"
TestParseAndBuild "https://user@192.168.0.1"
TestParseAndBuild "https://[2001:db8::1]/path"
TestParseAndBuild "data:text/plain;base64,SGVsbG8sIFdvcmxkIQ%3D%3D"
---
