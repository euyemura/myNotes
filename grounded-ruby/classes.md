# Classes

Classes are objects whose class is 'Class'.  It's weird.

We read all about instance methods and instance variables.  We talked about getters and setters, but I think the best way to do these methods is simply to use the attr_accessor or writer or reader.

Then, we talked about inheritance, simple stuff.

The next thing we are talking about is Class methods.  These are methods that are defined directly on the class, and thus they may not be accessible to the instances created from those classes.  

You'll want to think about when you are going to use a Class method.  For example, for tickets, we created a class method called `Ticket.most_expensive`

```ruby
def Ticket.most_expensive(*tickets)
  tickets.max_by($:price)
end
```

This makes sense to be defined for the Class itself, as opposed to the individual instances, as it speaks for all tickets.

Here is another example,

```ruby
class Temperature
  def Temperature.c2f(celsius)
    celsius * 9.0/5 + 32
  end

  def Temperature.f2c(fahrenheit)
    (fahrenheit - 32) * 5/9.0
  end
end  

puts Temperature.c2f(100)
# remember, we don't even have to instantiate a Temperature, because a class is already an object. Temperature is already an object, it just happens to have a Class method called 'new'
```

Looking forward, it would probably be better to make a module for this, same with the Dictionary possibly, but I think what I should have done was make the word_matcher a module possibly, not sure yet.  

Remember, class methods are not passed down to the instantiated versions of themselves.  Here are three important principles.

1. Classes are objects.
2. Instances of classes are objects, too.
3. A class object (like Ticket) has its own methods, its own state, and its own identity.  It doesn't share these things with instances of itself.  Sending a message to Ticket isn't the same thing as sending a message to fg or cc or any other instance of Ticket.

## Talking about methods, or should I say, referring to methods

When talking about instance methods, we write it like this...

- `Ticket#price`

When talking about Class methods, we write it like this...

- `Ticket.most_expensive` or `Ticket::most_expensive`

Look familiar??

## Constants up Close  

Constants are an important aspect of Classes, we often use them as the name of Classes, like I just did.  Class.

Constant definitions generally go at the top of the Class definition, or near the top.  

For example, in our Ticket class, we can create a list of venues that is constant.

```ruby
class Ticket
  VENUES = ["Convention Center", "Fairgrounds", "Town Hall"]

  def initialize(venue, date)
    if VENUES.include?(venue)
      @venue = venue
    else
      raise ArgumentError, "Unknown venue #{venue}"
    end
    @date = date
  end
end

```
I wonder if it would have been better to create a constant for the words in our Dictionary, probably.... lol.

What the hell, that's so dope, you can put logic inside of your initialize method!  And just like instance variables, these constants can be referenced anywhere inside your class definition.

But you can also reference these constants outside of the class definition.

`puts Ticket::VENUES`

And now we can access this constant, look at other examples.

`Math::PI` although Math is technically a module, the method to access the constant inside of it is the same.

### Changing constants

You can change them in two different ways, literally just reassign it.

```ruby
A = 1
A = 2
```

```ruby
venues = Ticket::VENUES
venues << "High School Gym"
```

We're not redefining the constant here so there are no warnings, instead we are augmenting an array who has no particular knowledge that it has been assigned to a constant.  

A Constant is still just an address to another object.  

Be aware of the difference between reassigning a constant name and modifying the object referenced by the constant.

Just remember, that all objects are instances of a Class, and a class is also just an Object.

Ruby kind of models its whole existence off of the 'general-to-specific' or the 'superclass-to-subclass' or the 'is a' question.

You can even use the is_a? method.

`Class.is_a? Object`

Objects can be nurtured, they can learn new behaviors, classes can also learn new behaviors, pretty incredible.  

Most of the times you don't see people adding methods to individual objects, or instances of a class, usually they are adding class-method definitions.
