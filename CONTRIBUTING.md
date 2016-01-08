# Contributing and Reporting

## Submitting a New Issue

1.  Before opening a new issue, search for previous discussions including closed
    ones. Add comments there if a similar issue is found.

2.  The best issues have steps to reproduce the error. Common ways to do that are:
    - A snippet of Ruby code
    - A CLI command with its output, e.g. `opal -ve 'p String != Symbol' # => false'`


## Submitting a Pull Request

1.  This is a TDD driven project. Before sending pull requests make sure all tests run and pass (see `HACKING.md` in this repo). If you make code changes, you should be testing those changes.

2.  Make sure to use a similar coding style to the rest of the code base. Some examples follow:
    - In Ruby and JavaScript code we use 2 spaces (no tabs)
    - In JavaScript we use `snake_case` for methods and variables

3.  Make sure to have updated all the relevant documentation, both for API (using _yardoc_ syntax) and the Guides

4.  Add a Changelog entry at the top of `CHANGELOG.md`


### A note on commits in PR

You could be asked to squash your commits during a PR review. That doesn't mean there's a preference for a single commit for each PR, rather it's a request to have each commit focused on a specific group changes and avoid the sequence of changes, fixups and reverts that tell an interesting story but in the end make the use of `git blame` quite difficult.

__That said, these are quite loose requirements in the spirit of keeping contributing enjoyable 🤓__

