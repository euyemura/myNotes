So you can always load a file somewhere in your Ruby file and it will run it as if it was in the file that's calling the other file.

Difference between `load` and `require`

Ruby keeps track of which files you have already loaded, in this case, if you call require multiple times on the same file, it won't reload it.

And you also don't require a file, you require a feature, in this way, it works a bit more in an abstract manner.

`load "loadee.rb"`

`require "./loadee.rb"`

I think require will work on files with different extensions other than `.rb`

Require doesn't know about the current working directory, ".", so you have to explicitly require it.

They say that on the whole you will be require'ing files instead of loading them.

### Require Relative

This is helpful if you want to require a file using a relative path.

For example,

`require_relative "loadee"`

## Ruby Command-Line Tools
