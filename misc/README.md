# URL parsing test file

`validation.txt` is a plaintext file with test cases for regex parsing of the URL. When the regex for parsing URI changes, it should be tested with these URIs to make sure nothing breaks. New test cases should be added to this file as the main regex is modified for new edge cases.

## Usage

1. Copy the regex from `lib.ua` into a new file.
2. Open https://regex101.com/ and make sure it's using the rust engine flavor. Enable "global", "multiline", "extended" modes.
3. Paste the regex into the expression field and the contents of `validation.txt` file into the "test string" field.
4. Make changes to the regex as necessary.

Then once you are satisfied with the new regex - paste it back into the `lib.ua` file.

1. Copy the modified regex into a new file.
2. Replace the regex in `lib.ua` with the new expression.
3. Add new tests to the `lib.ua` file as necessary.
4. Run `uiua test lib.ua` to run the tests.
