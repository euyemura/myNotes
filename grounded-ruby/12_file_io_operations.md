# File and I/O Operations

- Keyboard input and screen output
- The IO and File classes
- Standard library file facilities, including `FileUtils` and `Pathname`
- The `StringIO` and `open-uri` library features

Remember standard library is not the core thats always there in say IRB or whatever, it's just what comes with Ruby that you still have to require.

## How Ruby I/O system is put together

IO is a class, and it handles most input and output streams by itself, or by its descendant class `File`.

### The IO Class

When a ruby program is initiated, it is aware of the standard input, output, and error streams.  All three are encapsulated by instances of IO, is the IO object like a global object.

```ruby
STDERR.class
# IO
STDERR.puts("Problem!")
# nil
STDERR.write("Problem!\n")
# 9
```

So I guess what I'm confused about is if we're just outputting things to the command line, then what's the point or difference between this and a regular puts.

STDERR, STDIN, and STDOUT are all constants that are automatically set when the program starts.  

STDERR: An `IO` object, it's purpose is to output status and error messages.  This means it is an IO object that is open to writing.

In addition to the puts method, IO objects have the `print` and `write` methods.  The return value is the number of bytes written, thus the 9.

IO is a ruby class, and just like all Ruby classes, you can mix in modules, IO includes the enumerable module.

### IO objects are enumerables

Remember the basis for all enumerables is that they have an `each` method upon which they can build everything else.

```ruby
STDIN.each {|line| p line}
This is line 1
"This is line 1\n"
This is line 2
"This is line 2 \n"
All separated by $/, which is a newline character
"All separated by $/, which is a newline character\n"
```

You can change the value of $/, which is the global input record seperator, what constitutes a new line in other words.

But we can change this value.

```ruby
$/ = "NEXT"
STDIN.each {|line| p line}
# so for each input, it'll print it, it's signified by a newline.
First line
Next line
NEXT
"First line\nNext line\nNEXT"
# it won't stop accepting input until you hit that global separator, which is NEXT
```

In this way, `$/` determines an IO object's sense of `each`

### STDIN, STDOUT, STDERR

Lets talk about the standard input, output, and error streams.  They are defaults, unless told otherwise.

Ruby assumes all input will come from keyboard, and all normal output will go to the terminal.  This is assuming that procedural I/O methods, like `puts` and `gets` operate on STDOUT and STDIN respectively.  

Error messages and STERR are a bit more complicated, nothing goes to STDERR unless someone tells it to, if you want to use it for output, you have to say it explicitly, unlike puts and print and p, which follow the STDOUT stream naturally, or by default.

```ruby
if broken?
  STDERR.puts("There's a problem")
end
# see how we are naming it explicitly right here.  
```

So, we have these constants of `STDIN STDERR and STDOUT` but we also have three global variables as well, `$stdin $stdout $stderr`, what's the point though?

#### The standard I/O Global Variables

So, these objects dictate where your output and input are going.

So, why would you want to have both constants of STDIN and also the global variable of $stdin, and all the other ones to.  Well, you are not supposed to actually change the constants, but you can change the global variables, if you change the global variables, you have access to more streams of input and output without having to give up the default ones of STDIN and STDOUT.

For example, if you want all output to go to a file, as well as to the standard out and standard error.  You can achieve this by reassigning the global variables.

```ruby
record = File.open("/ruby-ground/test_read", "w")
old_stdout = $stdout
$stdout = record
$stderr = $stdout
puts "This is a record"
z = 10/0
```

Ok that didnt work for me, and I'm too lazy to try and get it to work.

## Basic File Operations

`File` is a built in class that inherits from IO.  

### The Basics of reading from files

Reading from a file can be performed one byte at a time, n bytes at a time, or one line a time (and remember each line is defined by $/ delimiter)

These operations are done by the `File` objects.

```ruby
f = File.new("ruby-ground/ticket.rb")
# be careful on where you are in irb right now, which directory are u in right now. These are all relative file paths.
f.read # will read entire file back as one string.
```

Using `fileobject.read` can be a bit too hammerish, meaning, you don't have much control since you're just reading the entire file back, and it certainly wouldn't be the most time efficient assuming it was a large file.

`file.close` You should close your files assuming you opened them with `File.new`, once we start using code blocks it'll be better.

```ruby
f = File.new("ruby-ground/stack.rb")
f.gets
# "require_relative 'stacklike'\r\n"
f.gets
# "class Stack\r\n"
f.readline
# "  include Stacklike\r\n"
```
`f.readline` and `f.gets` are almost the same except in how they treat the end of the file, `readline` will raise a fatal error, `gets` will just return nil.

`f.readlines` you caan get all the lines back as an array.

`f.rewind` puts you back at beginning of file

```ruby
f.readlines
# assuming you continued from the last section, this wouldn't give you the lines from the start, you have to rewind to the beginning first.
f.rewind
# 0
f.readlines
#  ["require_relative 'stacklike'\r\n", "class Stack\r\n", "  include Stacklike\r\n", "end\r\n", "\r\n", "s = Stack.new\r\n", "\r\n", "s.add_to_stack(\"item one\")\r\n", "s.add_to_stack(\"item two\")\r\n", "s.add_to_stack(\"item three\")\r\n", "puts \"Objects currently on the stack:\"\r\n", "puts s.stack\r\n", "taken = s.take_from_stack\r\n", "puts \"Removed this object:\"\r\n", "puts taken\r\n", "puts \"Now on stack:\"\r\n", "puts s.stack\r\n"]
```

`f.each` == `f.each_line` allows you to iterate over all of the lines in a file.

```ruby
f.each {|line| puts "Next line: #{line}"}
# again you have to rewind assuming you continued on.
f.rewind
f.each {|line| puts "Next line: #{line}"}
# Next line: require_relative 'stacklike'
# Next line: class Stack
# Next line:   include Stacklike
# Next line: end
# Next line:
# Next line: s = Stack.new
# Next line:
# Next line: s.add_to_stack("item one")
# Next line: s.add_to_stack("item two")
# Next line: s.add_to_stack("item three")
# Next line: puts "Objects currently on the stack:"
# Next line: puts s.stack
# Next line: taken = s.take_from_stack
# Next line: puts "Removed this object:"
# Next line: puts taken
# Next line: puts "Now on stack:"
# Next line: puts s.stack
#  => #<File:ruby-ground/stack.rb>
```

### Byte- and character-based file reading

`f.getc` will return one characyer at a time.  
`f.ungetc("X")` : you've essentially put back a character from where you were.
`f.gets # "Xlass ticket\n"` see, now when you get that line again, you have X as the first character.

`f.getc` == `f.readchar` but readchar raises fatal error at end of file.

`f.getbyte` == `f.readbyte` similarly.

Remember, the number of bytes and the number of characters may not be the same, and at any given position, the two may return different values, may, not necessarily.  

### Seeking and querying file position

The `File` object has a sense of where it is, this can be queried, it can be changed using different methods.  

`pos` with this method we can ask the `File` object where it is.

```ruby
f.rewind
# 0
f.pos
# 0
f.gets
#"class Ticket\n"
f.pos
# 13, now we are on the 13th character.

f.pos = 10
# here we are defining where the position should be.
f.gets
# "et\n" now this value is a bit weird, since we're not starting at the correct position in the line.
```

That last return is what the File object considers a line as of byte 10, everything from that position onwards until the next newline( or, until the next occurence of `$/`, which happens to be the newline. )

`seek` the seek method lets you move around in a file by moving the position pointer to a new location.  it's either defined by where the position pointer currently is or from the start of a file or the end, you tell it.

```ruby
f.seek(20, IO::SEEK_SET)
# == f.seek(20) == f.pos = 20
# i think this is frmo the begining of the file.
f.seek(15, IO::SEEK_CUR)
# 15 bytes from where we currently are
f.seek(-10, IO::SEEK_END)
# 10 bytes from the end.  
```

We've been looking at the `File` object for reading methods, but the class itself also has some reading methods.

### Reading files with `File` class methods

```ruby
full_text = File.read("myfile.txt")
# assuming you are in the correct directory, this returns to you the entire text as a string.
lines_of_text = File.readlines("myfile.txt")
# in this case you get an array of all the lines.
# They will open the file and close the file for you, so you don't have to do all that extra work.
# So these methods are all about convenience really.
# this tool still isn't really the best, as you are still getting the whole file, which you may just not need.  
```

### Writing to files

Writing to a file involves using `puts` `print` and `write` on a `File` object, not the class. It has to be opened in write or append mode. Write mode is indicated by 'w' as the second argument to new, as opposed to what we did earlier where we didnt give a second argument.

In this mode, the 'w' mode, the filie is created! IF it already existed, the old version is overwitten, so be careful. In append mode, a 'a' instead of a 'w' as the second argument, whatever is added is appended to the end of the file, if the file doesn't exist, then the file will be created.

```ruby
f = File.new("data.out", "w")
f.puts "Eric A. Uyemura, Rubyist"
f.close
#OMG IT WORKED
puts File.read("data.out")
# you puts it so that it doesnt have new line.
# we dont need to close the file here, because we are using the class method.
f = File.new("data.out", "a")
f.puts "Yukihiro Matsumoto, Ruby creator"
f.close
puts File.read("data.out")
p File.readlines('data.out')
```

let's see if it works.
SO AWESOME

As you can see here we have to do explicit opening and closing of Files in order to work with them, but if we use blocks then it takes a lot of the legwork out of it.

### Using blocks to scope file operations

If you call `File.open` with a code block, the block will receive the File object as it's only argument.

First i made a file called records.txt

```
Pablo Casals|Catalan|cello|1876-1973
Jascha Heifetz|Russian-American|violin|1901-1988
Emanuel Feuermann|Austrian-American|cello|1902-1942
```

Now we can write a code block that will report on this file.

```ruby
File.open("records.txt") do |f|
  #this while loop means as long as record isn't nil, which it will be once it hits the end of the file, we will output stuff in this format.
  while record = f.gets
    name, nationality, instrument, dates = record.chomp.split('|')
    puts "#{name} (#{dates}), who was #{nationality}, played #{instrument}"
  end
end
```

Here's an alternative way to do this...

```ruby
File.open('records.txt') do |f|
  f.each do |line|
    name, nationality, instrument, dates = line.chomp.split('|')
    puts "#{name} (#{dates}), who was #{nationality}, played #{instrument}"
  end
end
```

This is a bit simpler, the while loop evaluated whether `f.gets` returned nil as its criteria to end, but the File object has an each function that will return to you lines one by one, so why not just use this built in functionality instead of rebuilding the wheel.

Don't read a whole file into an array and then iterate, just iterate over the file and save the space in memory.

```ruby
# sample record in members.txt
# David Black male 55
count = 0
total_ages = File.readlines("members.txt").inject(0) do |total,line|
  count += 1
  fields = line.split
  age = fields[3].to_i
  total + age
end
puts "Average age of group: #{total_ages / count}"
```

Here we save all the lines of the file into an array with the File.readlines part.

But, why not just iterate over everything directly.

```ruby
count = 0
total_ages = File.open("members.txt") do |f|
  f.inject(0) do |total,line|
    count += 1
    fields = line.split
    age = fields[3].to_i
    total + age
  end
end
puts "Average age of group: #{total_ages / count}"
# we don't need to do each because of course, inject is an enumerable method which builds upon each.  
```
This approach negates the necessity for an intermediate array.

### File I/O exceptions and errors

Just know, you should be aware that any Errno exception is basically a system error percolating up through Ruby, they aren't Ruby specific errors, something wrong happened at a system level.

## Querying IO and File Objects

IO and File objects can be queried on numerous criteria, IO class has some of these query methods, and it's descendant, File, adds upon them.

`File` has query methods, and `FileTest` also has some.

```ruby
File.size("code/ticket2.rb")
#219
FileTest.size("code/ticket2.rb")
#219
File::Stat.new("code/ticket2.rb").size
#219
```

### Getting information from the File class and the FileTest module

- What is it?
- What can it do?
- How big is it?

```ruby
#does a file exist?
FileTest.exist?("/usr/local/src/ruby/README")
# is the file a directory? A regular file? a symbolic link?
FileTest.directory? ("/home/users/dblack/info")
FileTest.file?("/home/users/dblack/info")
FileTest.symlink?("/home/users/dblack/info")
```

How to get information from the File::Stat constant.

```ruby
File::Stat.new("code/ticket2.rb")
File.open("code/ticket2.rb") { |f| f.stat }
# both of the above method give the same output.
```

## Directory manipulation with the Dir class

The `Dir` is like the `File` but for directories, it'll let you query what is inside of a directory.

```ruby
d = Dir.new("/usr/local/src/ruby/lib/minitest")
#you'll have to adjust this path to your system, which is rough due to the whole WSL
```

### Reading a directory's entries

You can view the directory's entries in two ways, using the `entries` method or the `glob` technique.

Globbing doesn't show hidden entries but it does allow for wildcard matching and for recursive matching in subdirectories.

### The entries method

Dir has a class method called entries, and all of its objects also have a method called 'entries'

```ruby
d = Dir.new("ruby-ground")
d.entries
# [".", "..", "baker.rb", "car.rb", "cargohold.rb", "celsius-fah", "data.out", "fibonacci.rb", "first_case.rb", "fussy.rb", "hello_world.rb", "loadee.rb", "master.rb", "new_car.rb", "person.rb", "phone_regex.rb", "read_from_file.rb", "records.txt", "rescue.rb", "stack.rb", "stacklike.rb", "test_read.txt", "ticket.rb"]

# look familiar? We can also do this...
Dir.entries("ruby-ground")
```

There's a bunch of other dir query and manipulation methods that don't seem very relavant for what I want to do so let's skip shall we?

## File tools from the standard library

`FileUtils` and `Pathname` are both quite useful for anyone wanting to do file manipulation.

### The FileUtils module

#### Copying, moving, and deleting files

```ruby
