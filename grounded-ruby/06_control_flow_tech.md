- Conditional Execution
- Loops and looping techniques
- Iterators
- Exceptions and error handling

Here's a list of control-flow techniques in Ruby

1. Conditional Execution: Execution depends on the truth of an expression.
2. Looping: A single segment of code is executed repeatedly.
3. Iteration: A call to a method is supplemented with a segment of code that the method can call one or more times during its own execution.
4. Exceptions: Error conditions are handled by special control-flow rules.

## If statements

```ruby
if condition
  # code here
end
```

Two new ways to write `if` statements

`if x > 10 then puts x end `
`if x > 10; puts x; end`

`if not (x == 1)`

`if !(x == 1)`

### Assignment syntax in condition bodies and tests


```ruby
if x = 1
  y = 2
end
```

Ok that's messed up, it's not testing whether x == 1, but it's assigning x to 1, which should evaluate to 1, which is truthy, and so y should equal 2 in the end correct?

```ruby
if false
  x = 1
end
p x # nil, because even though it's not assigned, it is created.  So even if the condition is never met, it's evaluated? like, if you created a method that only ran if you called it, and in that method you assigned something, but u never called it, would it still have a space created for it? Let's see.
p y # raises an error, y is unknown, it's never created
```

```ruby
if x = y
  puts "Hello"
end
```

This one is interesting, you don't get the warning here, as y could be equal to false, in which case the test may fail.

But why would you use an assignment as a conditional statement, I still am not really sure but apparently the example below is one reason, as if the result of the assignment is not nil, it'll go through some logic, else, it will not.

```ruby
name = "David A. Black"
if m = /la/.match(name)
  puts "Found a match!"
  print "Here's the unmatched start of the string: "
  puts m.pre_match
  print "Here's the unmatched end of the string: "
  puts m.post_match
else
  puts "No match"
end
```

However you could rewrite it like this.

```ruby
m = /la/.match(name)
if m
...
```

### Case Statements

A case statement starts with an expression, usually a single object or variable, but any expression can be used, and walks it through a list of possible matches.

Here's an example.

```ruby
print "Exit the prgoram? (yes or no): "
answer = gets.chomp
case answer
when "y", "yes"
  # pretty awesome you can put multiple cases inside one when condition.
  puts "Good-bye!"
  exit
when "no"
  puts "Ok, we'll continue"
else
  puts "that's an unknown answer -- assuming you meant 'no'"
end
puts "Continuing with program ...."
```

#### How `when` works

The case looks for a match following a `when` clause.

`when` calls the `===` operator in ruby, the case equality method.   

Here's another version of that written with the 'threequal' operator.

```ruby
if "yes" === answer
  puts "Good-bye!"
  exit
elsif "no" === answer
  puts "Ok, we'll continue"
else
  puts "That's an unkown answer-assuming you meant 'no'"
end
```

Case/when logic really boils down to these `object === other_object` statements.  which is really,  `object.=== (other_object)`

### Programming Objects' Case Statement Behavior

Here's how to define your own case statement behavior.

`a === b` == Does `b` belong in a box of `a`
`String === 'hello world'` This would be true, as `'hello world'` does belong in the box of `String`, as it is an instance of string, but not the other way around.

```ruby
class Ticket
  attr_accessor :venue, :date
  def initialize(venue, date)
    self.venue = venue
    self.date = date
  end

  def ===(other_ticket)
    self.venue == other_ticket.venue
    # so whatever object you give to this method, it's going to check for it's venue and make sure it's the same as the other venue
  end
end
ticket1 = Ticket.new("Town Hall", "07/08/13")
ticket2 = Ticket.new("Conference Center", "07/10/13")
ticket3 = Ticket.new("Town Hall", "08/08/13")

puts "ticket1 is for an event at: #{ticket1.venue}"

# here comes the case statements

case ticket1
when ticket2 # if ticket2.===(ticket1)
  puts "Same Location as ticket2!"
when ticket3 # if ticket3.===(ticket1)
  puts "Same location as ticket3!"
else
  puts "No Match"
end
```

When you're talking about `case` statements, you're really saying that the case is the instance, and whatever the when statement is, does the case (the instance) fit in the box of the when (the box)

I wonder if you could put this in an each loop, go through all of the tickets.

Lot's of syntactic sugar going on in the above example.

You don't even necessarily need a test to case, it can just be testing various if statements.

So, if given no `==` or whatever, the when will default to a `threequal` or `case equality matcher` otherwise, you can tell it what kind of behavior that you want.

```ruby
case
when user.first_name == "David", user.last_name == "Black"
  puts "You might be David Black."
when Time.now.wday == 5
  puts "you're not David Black, but at least it's Friday!"
else
  puts "You're not David Black, and it's not even Friday"
end
```

## Loops!  

### the `loop` method

`loop codeblock`
`loop { puts "Looping Forever!"}
 loop do
  puts "looping forever"
 end`

Same exact thing, so I suppose it's when there is a block of code that can be run multiple times, thats when you put `do`.

#### Breaking out of a loop!

```ruby
n = 1
loop do
  n = n + 1
  puts n
  break if n > 9
end

n = 1
loop do
  n = n + 1
  # when i put n + 2, it'll loop forever, since it never will equate to 10.
  puts n
  next unless n == 10
  break
end
```

The two above examples do the same thing, as it only gets to the break point once n is 10, or bigger than 9 for the first case.

### Condition Looping with `while` and `until` keywords

#### `while`

```ruby
n = 1
while n < 11
  puts n
  n = n + 1
end
puts "Done"
```

```ruby
n = 10
begin
  puts n
end while n < 10
```

This way ensures that the loop will happen at least once.

Don't forget about until...

#### One liner syntax

```ruby
n = 1
n = n + 1 until n == 10
puts "We've reached 10!"
```

This is essentially the same as doing until at the start, not the end way which will always at least loop once.

### For Loop!

```ruby
celsius = [0, 10, 20, 30, 40]
puts "Celsius\tFahrenheit"
for c in celsius
  puts "#{c}\t#{Temperature.c2f(c)}"
end
```

```ruby
def my_loop
  yield while true
end

my_loop { puts "My-looping forever" }
```

The code block is given to yield, the code block is not an argument, it is something that can be added to a method call as part of the syntax, you can use it String#split to do something to each returned element, which is pretty cool.

### Times

The behavior of times illustrates that yielding to a block and returning from a method means two different things.  

Also, times is an instance method of the Integer class.

```ruby
5.times { puts "Writing this 5 times" }
```

You only return from a method once, but a method can yield to a code block as many times as you want.  It yields control to a code block.  

Yield can take an argument, in times it would be the integer it is on....

```ruby
class Integer
  def my_times
    c = 0
    until c == self
      yield(c)
      c += 1
    end
    self
  end
end
```

So this is interesting, when you give an argument to yield, it will be whatever is in the block parameter....

### Each

For each, the block parameter would be the value at whichever index you are at in the array...

The return value of each, not the yield block parameter, would be the original array.

```ruby
class Array
  def my_each
    for el in self do
      yield(el)
    end
    self
  end
end

class Array
  def my_each
    c = 0
    while c < length
      yield(self[c])
      c += 1
    end
    self
  end
end
class Array
  def my_map
    c = 0
    new_arr = []
    while c < length
      new_arr << yield(self[c])
      c += 1
    end
    new_arr
  end
end
class Array
  def my_map
    c = 0
    new_arr = []
    self.each { |el| new_arr << yield(el)}
    new_arr
  end
end

```

Now we are talking about scope for blocks.  blocks have the same local scope as where they are called, so look at this.

```ruby
def block_scope_demo_2
  x = 100
  1.times do
    x = 200
  end
  puts x
end
block_scope_demo_2 # 200 because they are the same.  
```

However, your block variable will never conflict with an outer local variable which means your block variable will always be in safe hands.

Here's a true block local...

```ruby
def block_local_variable
  x = "Original x!"
  3.times do |i;x|
    x = i
    puts "x in the block is now #{x}"
  end
  puts "x after the block ended is #{x}"
end
```

Now you can safely use x without having any collisions or worrying about reassigning or anything like that.

## Error Handling and Exceptions

Exceptions are Ruby's way to handle unrecoverable error conditions.  These error conditions can be rescued as we'll see in a moment.  

Here's one way to look for syntax errors.

`ruby -cw filename.rb`

You can raise an exception for sure, and this means stopping normal execution of the program and either dealing with the problem or exiting the program completely.

When you see an error, like 'ZeroDivisionError', it comes from the class Exception.

Whether your program stops or not depends on if you provided an 'rescue' statement.

### Using Rescue

```ruby
print "Enter a number"
n = gets.to_i
begin
  result = 100/n
rescue # ZeroDivisionError ( you can put an optional argument of the error that you are screening for)
  puts "Your number didnt work. was it zero?"
  exit
  # it is at this point we stop the program, this isn't a break, it stops the program entirely.
end
puts "100/#{n} is #{result}"
```


Here's my cooler version of it.

```ruby
while true
  print "Enter a number: "
  n = gets.to_i
  begin
    result = 100/n
  rescue
    puts "This couldn't be calculated, did you enter zero?"
    next
  end
  puts "100/#{n} is #{result}"
  break
end
```

HEre's a better version of that last one

```ruby
loop do
  print "Enter a number: "
  n = gets.to_i
  begin
    result = 100/n
  rescue
    puts "This couldn't be calculated, did you enter zero?"
    next
  end
  puts "100/#{n} is #{result}"
  break
end
```

### Using rescue inside methods and code blocks .

If it is already within a method or code block, there is no need to say begin, assuming you want the entirety of the method or code block to be governed by rescue.

HEre's a file opening example!

```ruby
def open_user_file
  print "File to open: "
  filename = gets.chomp
  fh = File.open(filename)
  yield fh
  fh.close
  rescue
    puts "Couldn't open your file!"
end

def open_user_file
  print "File to open: "
  filename = gets.chomp
  begin
    fh = File.open(filename)
  rescue
    puts "couldn't open your file!"
    return
  end
  yield fh
  fh.close
end
```

### Raising Exceptions Explicitly

```ruby
def fussy_method(x)
  raise ArgumentError, "I need a number under 10" unless x < 10
end
# this will raise an error unless x is smaller than 10.
fussy_method(20)
# So this would def cause an error.

begin
  fussy_method(20)
rescue ArgumentError
  puts "That was not an acceptable number!"
end

raise "Problem!" == raise RuntimeError, "Problem!"
```

#### Capturing an Exception in a Rescue Clause

You have an object, the exception object, and it holds important information.

You access it with the `=>` operator, and the `rescue` command.

Since it is an object, it responds to various messages, like, `backtrace` and `message`.  

`backtrace` returns an array of strings representing the call stack at the time the exception was raised.  It's like a history of all the code prior to what happened.

`message` provides the message string provided to `raise`  if given any of course.

Here's an updated fussy method call, where we rescue the faulty call, and we also utilize all of the errors.

```ruby
begin
  fussy_method(20)
rescue ArgumentError => e
  puts "That was not an acceptable number!"
  puts "Here's the backtrace for this exception:"
  puts e.backtrace
  puts "And here's the exception object's message:"
  puts e.message
end
```

When you raise an error, you're really instantiating an object of the class ArgumentError for example, or ZeroDivisionError.

Sometimes we want to reraise in a rescue clause.

```ruby
begin
  fh = File.open(filename)
rescue => e
  logfile.puts("User tried to open #{filename}, #{Time.now}")
  logfile.puts("Exception: #{e.message}")
  raise
end
```

This is to intercept that exception, that error, and then to make a note of it, give it information, and then go back to its errory ways.

### The `ensure` clause

Here's an example, you have a data file, and you want to read a line off of it.  if this data file does not contain a particular substring, you raise an exception, if it does, you return the line.  If it doesn't, the error you will raise is an ArgumentError, but no matter what, we will close the file handle no matter what.

```ruby
def line_from_file(filename, substring)
  fh = File.open(filename)
  begin
    line = fh.gets
    raise ArgumentError unless line.include?(substring)
  rescue ArgumentError
    puts "Invalid line!"
    raise
  ensure
    fh.close
  end
  return line
end
```

Ok not sure what is happening here.

One of the problems with the code above is that the ArgumentError isn't exactly the best fitting error to desribe here, but we can absolutely create our own error.  

### Creating your own exception classes

You can either create a descendant of  `Exception` or from a descendant class of Exception... like ArgumentError

```ruby
class MyNewException < Exception
end
begin
  puts "About to raise a new exception..."
  raise MyNewException
rescue MyNewException => e
  puts "just raised an exception: #{e}"
end

raise MyNewException, "Some new kind of error has occurred that we've never seen before in millenia."
```

We will see this again in the old example as well as the addition of namespacing!

```ruby
module TextHandler
  class InvalidLineError < StandardError
  end
end

def line_from_file(filename, substring)
  fh = File.open(filename)
  begin
    line = fh.gets
    raise TextHandler::InvalidLineError unless line.include?(substring)
  rescue TextHandler::InvalidLineError
    puts "Invalid line!"
    raise
    # this second raise, since it's within the rescue for a specific error, will not result in standard RuntimeError, but whatever error that you specified.
  ensure
    fh.close
  end
  return line
end
```
