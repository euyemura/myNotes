- String Object creation and manipulation
- Methods for transforming strings
- Symbol semantics
- String/symbol comparison
- Integers and floats
- Time and date objects

Scalar: One dimensional.

This means an object that holds a single value, unlike a collection or a container that holds many values, like a hash or an array.

Scalar objects: string, symbols, integers, floats, Time, Date, and DateTime objects.

## Strings

The only time you need to escape a character is when you are using double quotes, because double quotes are the only ones that allow for behavior, like string interpolation and representing carriage returns. well, the only time you have to escape a character in singe quotes is when you want to use single quotes within the single quoted string.

So, in double quotes "Hello \n" would equal a carriage return, it would have to be escaped like this "Hello \\n"

Other quoting mechanisms!

```ruby
%q-A string-
%Q/A double quoted string not needing escapes for quotation marks/
$[Yet anther double quoter]
```

### Here Documents

A here doc is a string that is present in the working file, not read from a different file.
```
text = <<EOM
adsffadfadf
fakdfasfd
adf;lsadf
EOM
```

This is pretty cool,

```ruby
text = <<-'EOM'
single-quoted!
Note the literal \n
and the literal #{2+2}
EOM
# "single-quoted!\nNote the literal \\n\nand the literal \#{2+2}\n"
a = <<EOM.to_i * 10
55
EOM
# output is 550
```

Other weird things with here docs...

```ruby
array = [1, 2, 3, <<EOM, 4]
So this is part of the heredoc which is definitely odd
umm
yeah
EOM
p array
#[1, 2, 3, "So this is part of the heredoc which is definitely odd\numm\nyeah\n", 4]

do_something_with_args(a, b, <<EOM)
SO this is part of the heredoc interesting
very interesting...
ok
EOM
```

the above is good when you dont want to clutter up your methd call i guess.

### Basic String manipulation

```ruby
string = "Ruby is a cool language"
string[5]
# returns 'i'
string[-1]
# returns 'e'
string[5,10]
# returns i and the next 9 characters, 10 characters in total.
string[5..10]
# returns the 5th thru 10th characters.

string[-12..-3]
# even though it starts negative it still must move from left to right.
string["cool lang"]
# if there's a match, it'll return the substring, otherwise, it will return nil.
```

Slice is a method that basically does the same thing as the bracket method.  The col thing is, if you use the bang version

```ruby
string.slice("cool")
# will again return the
string.slice!("cool ")
# now it's gone. remember, all of the other syntax from up above will work as well.
```

After doing any of these, you can also use the array notation to replace whatever you have retrieved to something else.

```ruby
string["cool"] = "great"
# "Ruby is a great language."
string[-1] = "!"
# "Ruby is a great language!"
```

### Concatenating strings

When you add strings together using the + operator, the original string is never changed, check this out.

```ruby
string = "Hello"
string + " world!"
string
#"hello" but then you can always do +=
```

If you want to permanently add them together, use the `<<` operator

```ruby
string = "Goodbye"
string << " world!"
string
```

String interpolation is of course another great way to add strings together, and the beautiful thing is, anything can go inside of the brackets.

```ruby
"My name is #{class Person
                attr_accessor :name
              end
              d = Person.new
              d.name = "Eric"
              d.name}"
# "My name is Eric"
```
Behind the scenes, Ruby is calling `to_s` on whatever is the return from the brackets.  
I think this next example is a bit convoluted but whatevs.

```ruby
class Person
  EYES = "brown"
  attr_accessor :name
  def to_s
    name
    # i think that this works because it's not just returning name, because that wouldn't work because this is an instance variable, it's because a person object has the method of name, however, since the default receiver is the object, it calls it on self.  
  end
end

eric = Person.new
eric.name = "Eric"
"Hello, #{eric}"
```
```ruby
# class practice
class Person
  attr_accessor :name
  def say_it
    @name
  end
end
# from what i can tell these are literally exactly the same.

class Person
  attr_accessor :name
  def say_it
    name
  end

  def shout_it
    @name
  end
end

eric = Person.new
 # => #<Person:0x00007fffbf798648>
eric.name = "ERic"
 # => "ERic"
eric.say_it.object_id == eric.shout_it.object_id
 # => true
```



### Querying Strings

```ruby
string = "Hello my name is Eric"
string.include?("Eric")
# true.. and remember that case does indeed matter here.
string.start_with?("Hello")
# true case matters for this as well.
string.end_with?("c")
# true
string.empty?
#this just tests if the object is empty. whitespace means its NOT empty
```

### Content queries

The `size` and `length` methods are the same!

```ruby
string.count("i")
# should return 2
string.index("Eric")
string.rindex("i")
# rindex will return the last place it was found
```

### String transformation

Generally there are three categories of string transformation.

1. Case
2. Formatting
3. Content

1. Case Transformation

```ruby
string = "Eric A. Uyemura"
string.upcase
string.downcase
string.swapcase
string.capitalize
# capitalize will only change the first letter in the string, it won't capitalize each word or anything like that, also, it doenst count a period as a sentence and capitalize every sentence or anything like that.
# and all of these methods have bang equivalents that will mutate the receiver object.  
```

2. Formatting Transformation

These are technically just a subset of content transformations, but who's counting?

```ruby
# rjust and ljust
string = "Eric A. Uyemura"
string.rjust(10)
# "          Eric A. Uyemura"
string.ljust(10)
# "Eric A. Uyemura          "
# ^^^ so the examples up above actually won't work, the argument given must be an integer greater than the length of the string.. and it'll add padding to whatever the difference is between the argument you give and the length of the original string.
string = "Eric A. Uyemura"
string.rjust(10)
# "Eric A. Uyemura"
string.ljust(10)
# "Eric A. Uyemura"
string.rjust(25)
# "          Eric A. Uyemura"
string.ljust(25)
# "Eric A. Uyemura          "
# You can also dictate what kind of characters will be put inside of that padding.
string.rjust(25, "><")
#"><><><><><Eric A. Uyemura"
# you can also put the string right in the center of it all.
string.center(21, "/")
# "///Eric A. Uyemura///"
# youc an also strip whitespace from either side with rstrip, lstrip, strip.
"    Hello there my name is      eric     ".strip
# "Hello there my name is      eric"   and this can be used with a bang to permanently remove the white space.
```

### Content transformation

`chop` and `chomp`

`chop` does not take any arguments, it'll always take off the last character of the string that you give it.

`chomp` defaults to the newline character, and will only take action if it finds that target string, you can also give it a string of any length and it will chomp it off if it appears at the end of the string.

They both have bang equivalents.

`clear` no matter what, it'll mutate the original array and clear it of all of its content.
`replace` will replace a string with with whatever argument you give to it, this is also a mutator.

```ruby
string = '(to be named later)'
string.replace('hello world')
string
# 'hello world'
```

`delete` remember how `count` counted all hte instances of whatever characters you passed it, delete does the same thing but deletes all of the instances.  So it doesnt targt whatever you pass in, it indiscrimnately deletes them.  And it also is NOT a mutator, you must use the bang version.  

```ruby
"Eric A. Uyemura".crypt("34")
# you must pass it a salt, and it'll will encryprt your string, it must be a two character salt. this is NOT a mutator
"a".succ
# "b"
"abc".succ
# "abd" it'll increment the last character by one on the character chart. this is not a mutator.
```

Every string consists of a sequence of bytes, the bytes map to characters, and this is all explained by the concept of encoding.

Strings will tell you their encoding.

`"hello".encoding`

### Symbols and their uses

The literal constructor for a symbol is just the colon, `:method_name`, or if you want spaces, `:"oh hello there it's special symbol time"`

You can also convert a string to a symbol,
`"hello".to_sym`
`"hello i'm a symbol now".intern`

It's also possible to convert a symbol to a string.

Two characteristics of symbols...

1. Immutability: Symbols can't be changed, like there's no appending to a symbol, `:a << :b`.  this is a weird idea to me, the integer object `4` can never be changed, you can add a number to 4 and be returned the object that is equal to that expression, but the actual object in storage will never change
2. Uniqueness: `:abc` is always `:abc` it's not like two equal strings that are really two different objects, they are the same object for symbols.  There's no `Symbol#new` method, because they're always unique, just like you can't have an integer with the `Integer#new` notation, it's always literal constructors.

Ruby uses symbols to keep track of all variable names, methods, and constants.  So any method that is available in your program will be a symbol, so literally any default ruby method is a symbol, there will be more than 3000 of them.  This means that every time ou create a variable assignment, the list of symbols goes up by 1.

#### Ok, so when do you actually use symbols??

Generally you either use them as method arguments or as hash keys!

##### As Method Arguments

`attr_accessor :name`
`"abc".send(:upcase)`

In the above example we are asking "abc" to perform it's method `:upcase`, but this can also be written as `"abc".send("upcase")`, this is probably the same as the `repond_to? `method, where it can either take a string or a symbol, when you provide the symbol, it saves some computational power as it does not have to go through the step of converting the string to a symbol.  And yes taht is the case for the `respond_to? ` method.

##### As Hash Keys

So, a hash consists of a key and a value, although we often see keys written as strings or symbols, it can actually take in anything, like another hash, an array, or an integer. Yes integers work just fine.

```ruby
e_hash = { :name => "Eric", :age => 27 }
e_hash[:name] # => "Eric"
```

So why use symbols as hash keys instead of strings.  Well, first off, Ruby can process symbols faster.  They look better, and it allows for the special syntax.  

```ruby
e_hash = { name: "Eric", age: 27 }
# see, the colon now goes after the symbol instead of before!
```

Think of symbols as integer-like entities dressed up in characters.

### Numerical Objects

Remember, whenever you divide integers, you will always get an integer back, if you want it to be exact, you must give it floats, only one of them has to be a float.  

### Time and Dates

First of all, you need to have those libraries!

`require 'date'`
`require 'time'`

```ruby
require 'date'
require 'time'
Date.today
#this is all assuming you have required those libraries.
puts Date.today
# remember, puts calls to_s on whatever you're calling, so, you can make it simpler by putsing or...
Date.today.to_s

puts Date.new(1992,2,1)
# you don't have to enter in a month or day, but it'll default to 1/1, the day will default to 1 if you only give a month
puts Date.parse("2003/6/9")
# you can have the zeros or not, this will parse a string written with forward slashes, interseting.
puts Date.parse("92/2/25")
# you don't need the full date, from 69 and below, it'll default to 2000.
puts Date.parse("Feb 25 92")
# it's really good at parsing dates, must be using regex.
```

#### Creating Time Objects

It looks like `time` is already required in irb, but `date` is not!

```ruby
Time.new
# 2019-03-17 20:53:31 -0700
Time.local(2019,3,17,18,56)
# 2019-03-17 18:56:00 -0700 this creates a time object, you can of course give it hours minutes and seconds as well,
require 'time'
Time.parse("March 17th, 2019, 8:57 pm")
# 2019-03-17 20:57:00 -0700 again, it's pretty good at its job.
```

#### Creating Date/Time objects

It's a subset of date, so make sure to require date .

```ruby
puts DateTime.new(2009, 1,2,3,4,5)
# 2009-01-02T03:04:05+00:00
puts DateTime.now
# 2019-03-17T21:05:22-07:00
puts DateTime.parse("October 23, 1973, 10:34 am")
# 1973-10-23T10:34:00+00:00
```

#### Date/time query methods

```ruby
dt = DateTime.now
dt.year
dt.hour
dt.day
dt.month
dt.minute
t = Time.now
t.month
t.sec
d = Date.today
d.day

d.monday?
dt.friday?
# false
dt.sunday?
```

YOu can also ask if its a leap year (leap?) or if its daylight savings time (dst? for time objects only) And yes it daylight savings time, because we've sprung forward.

#### Date/time formatting methods

Go to this section to see how to format your date and time objects however you want!

Date, time, and datetime all have the date information but only two have time information, which is why you can do the to_date and to_datetime, well that doesn't explain why, it explains why when you are converting date to datetime, it'll default to midnight as date doesn't have access to the time.

You can also manipulate date and time objects and add months and add days and seconds or whatever, this may be useful if you're making an app that is like a timer, three hundred days from now type of thing.  

+ and - are for days, and the >> is for months

```ruby
dt = DateTime.now
puts dt + 100
puts dt >> 3
puts dt << 10

d = Date.today
puts d.next
# next day
puts d.next_year
puts d.next_month(3)
puts d.prev_day(10)
```

You can iterate over them too...

```ruby
d = Date.today
next_week = d + 7
d.upto(next_week) {|date| puts "#{date} is a #{date.strftime("%A")}"}

```
2019-03-17 is a Sunday                                                              2019-03-18 is a Monday                                                              2019-03-19 is a Tuesday                                                             2019-03-20 is a Wednesday                                                           2019-03-21 is a Thursday                                                            2019-03-22 is a Friday                                                              2019-03-23 is a Saturday                                                            2019-03-24 is a Sunday   

is the output, minus all the weird formatting.  
