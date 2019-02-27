This chapter covers

- Object and object orientation
- Innate versus learned object capabilities
- Method parameter, argument, and calling syntax
- Local variable assignment and usage
- Object references

Basically everything in Ruby is an object, you generally send them messages, these messages generally correspond to names of methods that you're asking the object to execute.

Generally in Ruby programming, you are creating objects, endowing them with abilities, and asking them to perform actions.

Every object is an instance of a particular class, and the behavior of individual objects is determined at least to some extent by the method definitions present in the object's class.

### Creating a Generic Object

Sidenote: A Class in Ruby is actually an Object as well, so objects aren't built upon classes so much as classes are built upon objects.

`obj = Object.new`

### Create a Method for Your object

```ruby
def obj.talk
  puts "I am an object"
  puts "(Do you object?)"
end
```

The object `obj` understands, or responds to, the message `talk`.

The dot (.) is the message-sending operator.  The message on the right is sent to the object( or receiver, as it's often called in this role) on the left.

We can make this object learn to convert celsius to fahrenheit.  This will also be an example of how we can give arguments to methods within objects. s

```ruby
def obj.c2f(c)
  c * 9.0/5 + 32
end
```

When you eventually call this, if it's done in irb, you wont have to give it to "puts" as irb will automatically display the return value.  if there was a noecho you would however.

This object we have created can talk and it can also convert celsius to fahrenheit, but this is a rather frankenstein-esque object, as it doesn't have any real inherent connections between its methods or its properties.

## Creating a Ticket Object

1. Create a ticket object, in this case, we are just instantiating a basic Object and storing it in the variable of ticket.

```ruby
ticket = Object.new

def ticket.date
  "01/02/03"
end

def ticket.venue
  "Town Hall"
end

def ticket.event
  "Author's reading"
end

def ticket.performer
  "Mark Twain"
end

def ticket.seat
  "Second Balcony, row J, seat 12"
end

def ticket.price
  5.50
end

print "This ticket is for: "
print ticket.event + ", at "
print ticket.venue + ", on "
puts ticket.date  + "."
print "The performer is "
puts ticket.performer + "."
print "The seat is "
print ticket.seat + ", "
print "and it costs $"
puts "%.2f." % ticket.price

```
This is definitely a simple method, however, it encompasses some important principles. So nothing of use can be done with the program without the data inside of the ticket object, you get the information by asking the ticket for the info via method calls. Ruby is all about asking objects to do things and to tell you things.

Let's shorten by using string interpolation

```ruby
puts "This ticket is for: #{ticket.event}, at #{ticket.venue}." + "The perfomer is #{ticket.performer}." + "The seat is #{ticket.seat}, "+ "and it costs $#{"%.2f" % ticket.price}"
```

## Innate Behaviors of Objects

Whenever an object is instantiated, it already is endowed with some properties and abilities and behaviors, not sure which one so I'll just name them all.

Here's a list of the methods that you already have access to with a newly made object.

`puts Object.new.methods.sort`

But here are some of the more important/commonly used ones.

- `object_id`
- `respond_to?`
- `send` (synonym: `_send_`)

Using the `Object.new` syntax creates a generic object.

However, `BasicObject.new` will result in like a object prototype/basic object that can't really do anything.


### object_id

So, generally, most objects have unique identifiers, however, the id for the number 1 is always the same as the id for the number 1, but the id for the string "hello" is not equal to itself, which is kinda crazy.

### respond_to?

```ruby
obj = Object.new
if obj.respond_to?("talk")
  obj.talk
else
  puts "Sorry, the object doesn't understand the 'talk' message"
end
```

This method is an example of <i>introspection</i> or <i>reflection</i>.

The `.method` is another example of respond to.

### send  

This is another cool one.  This is another way to send a message to an object to ask it to do something.  Here's an example with our ticket object.

```ruby
print "Information desired: "
request = gets.chomp

if ticket.respond_to?(request)
  puts ticket.send(request)
else
  puts "No such information is avaialable."
end
```
