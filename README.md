# URI parser for Uiua

Uiua implementation for parsing Uniform Resource Identifiers into it's components for further manipulation. This library also includes a method for building the URI back from the parsed data.

## Note

This implementation doesn't follow any spec, it's only my best attempt. 

The parser just matches a URI to hand-written regular expression instead of properly tokenizing and rigorously parsing input. That means that the parser is relatively lax and may parse what is a technically invalid URI. 

It may also be incomplete and fail to match URIs with some edge cases. Please create an issue for such cases.

## Usage

Requires at least `Uiua v0.10.0-dev.1`.

```uiua
# Experimental!

# Import the library
URI ~ "git: github.com/ekgame/uiua-uri-parser"

# Parse URI to it's components
URI~Parse "https://google.com/search?q=hello+world"

# The components are just a map that can be modified
# For example, we can change the domain for the URI
insert "domain" "bing.com"

# We can then build the URI back into string with the changes
URI~Build
```

[Try the code in the online editor](https://www.uiua.org/pad?src=0_10_0-dev_1__IyBFeHBlcmltZW50YWwhCgojIEltcG9ydCB0aGUgbGlicmFyeQpVUkkgfiAiZ2l0OiBnaXRodWIuY29tL2VrZ2FtZS91aXVhLXVyaS1wYXJzZXIiCgojIFBhcnNlIFVSSSB0byBpdCdzIGNvbXBvbmVudHMKVVJJflBhcnNlICJodHRwczovL2dvb2dsZS5jb20vc2VhcmNoP3E9aGVsbG8rd29ybGQiCgojIFRoZSBjb21wb25lbnRzIGFyZSBqdXN0IGEgbWFwIHRoYXQgY2FuIGJlIG1vZGlmaWVkCiMgRm9yIGV4YW1wbGUsIHdlIGNhbiBjaGFuZ2UgdGhlIGRvbWFpbiBmb3IgdGhlIFVSSQppbnNlcnQgImRvbWFpbiIgImJpbmcuY29tIgoKIyBXZSBjYW4gdGhlbiBidWlsZCB0aGUgVVJJIGJhY2sgaW50byBzdHJpbmcgd2l0aCB0aGUgY2hhbmdlcwpVUkl-QnVpbGQK)

## Components

Take this URI for example:
```
ftp://username:password@ftp.example.com:21/path/to/file?key=value&key2[]=value2#fragment-test
```

It will be split into a map with these components:

| Key      | Value                   |
|----------|-------------------------|
| schema   | ftp                     |
| userinfo | username:password       |
| domain   | ftp.example.com         |
| port     | 21                      |
| path     | /path/to/file           |
| query    | key=value&key2[]=value2 |
| fragment | fragment-test           |

Any parsed URI will have all keys in the map, but the values may be empty strings if the component is not present.

# Acknowledgements
- Test cases adapted from [this comment in StackOverflow](https://stackoverflow.com/a/77493332).