- Literal Object constructors
- Syntactic sugar
- Dangerous and or destructive methods
- The `to_*` family of conversion methods
- Boolean states and objects, and `nil`
- Object-comparison techniques
- Runtime inspection of objects' capabilities

So of course, in this section we are talking about built-in classes.  Now, everything in Ruby is an object, which makes this statement rather broad, essentially, this is Ruby.

### Goals of this Chapter

1. Creating a foundation for later chapters.
2. Giving important Ruby information.

- Literal Object constructors: ways to create objects without using the `new` method call.
- Syntactic sugar: You know what that is.
- "dangerous" and destructive methods: Methods that change whatever they were called on, mutators.
- `to_*` conversion methods: Changes an object to an object of a different class.

## Literal Constructors

A way to instantiate a new object without the call to `new`

You know all of these.  Symbol and Integer can only be instantiated using a literal constructor.

## Syntactic Sugar

```ruby
x = 1 + 2
x = 1.+(2) # this is what is happening behind the scenes
# you are allowed to change what the + method does, you can redefine it in certain contexts if you would like.
```

Here are two examples of redefining those standard methods.

```ruby
obj = Object.new
# This one is interesting, instead of defining it in the class, we're defining it as a singleton method, so that only this specific object has access to it.  
def obj.+(other_obj)
  "Trying to add something to me, eh?"
end
puts obj + 100

class Account
  attr_accessor :balance
  def initialize(amount = 0)
    self.balance = amount
  end

  def +(x)
    self.balance += x
  end
# this kind of gives you a shortcut to write the += method, as it condenses it into one step in this version.
  def -(x)
    self-balance -= x
  end

  def to_s
    balance.to_s
  end
end
```
This being said however, you cannot change any of the literal object constructors  

```ruby
class Banner
  def initialize(text)
    @text = text
    # @other_text = "hello world"
  end

  def to_s
    @text
  end

  def +@
    @text.upcase
  end

  def -@
    @text.downcase
  end

  def !
    @text.reverse
  end
end

banner = Banner.new("Eat at David's!")
puts banner
# this only works when the class can only return one thing, such as @text, when there are two, it'll just show the object.
puts +banner
puts -banner
puts !banner
puts (not banner)
```

So check out the above example,, first of all, if you wanted to modify any of the unary operators, you just have to use the @ sign in order to signify that you are changing it.  

I'm still not sure why the to_s thing is there, don't think it really changes anything, it's just a reader method in this case.

In the bang method, it also gives you access to the long form, `puts not banner`

### Bang(!) methods and "danger"

They're labelled as destructive and dangerous because they change the object that they were called on.

```ruby
str = "hello"
str.upcase # "HELLO"
str # hello
str.upcase! # "HELLO"
str # "HELLO"
```

If ou call the nonbang version of the method on the object, you are creating a new object.  If you call teh bang version, you operate in place and change that same object.

Here is one consideration, when you don't use the bang version, you use more space in memory, as you are creating a new object.  If you use the bang, you are never creating more objects from that method.

A bang method is not the same thing as a destructive method, they're often the same, but not always.

#### Don't use `!` except in M/M! Method Pairs

This is more in terms of when you are writing methods, don't just write a method with a ! because you have deemed it dangerous, make sure that there is a non bang version that you have written and that this other one is dangerous in comparison to that.  

#### Don't equate `!` notation with destructive behavior, or vice versa

`!` does not mean destructive, it means dangerous or possibly unexpected behavior.  

A method isn't dangerous if it's name, despite not having a `!` is already suggesting its dangerous, because there's no unexpected behavior.

Ok... sure?

### Built-in and custom `to_*` conversion methods

1. `to_s` : Every ruby object except for BasicObject responds to this.  Interestingly enough, puts actually calls to_s on whatever puts is being called on!  When you use string interpolation, you are getting a `to_s` interpretation of it. The only exception to puts calling `to_s` on whatever called it is for arrays, puts has special behavior for those.

Other string methods, `inspect` and `display`

2. `to_a` : Converts it into an array.  `*` unarrays it, strips it into a bare list. `[*arr]` will just return an array, because the original array is stripped of its brackets, and then the array literal constructor puts them back on.

Here's an actual example of using it.

```ruby
def combine_names(first_name, last_name)
  first_name + " " + last_name
end

names = ["Eric", "Uyemura"]

puts combine_names(*names)
```

### Comparing Two Objects

#### Equality Tests

```ruby
a = Object.new
b = Object.new
a == a
a == b
a != b
a.eql?(a)
a.eql?(b)
a.equal?(a)
a.equal?(b)
```

So, `==` vs `.eql?(compared_object)` vs `.equal?(compared_object)`

Well, `.equal?` will check for identity, are what you are comparing literally the exact same object in memory??

```ruby
string1 = "text"
string2 = "text"
string1 == string2
string1.eql?(string2)
string1.equal?(string2)
```

Only the last one returns false, as two strings that have the same characters are still not the same object in storage, an integer should be however.

Something that is interesting about this is that generally the `==` and the `.eql?` methods are often redefined for custom classes.  Let's look at an example.

### Redefining Equality Example

1. Mix in a module called `Comparable` (a predefined Ruby class)
2. Define a comparison method with the name <=> as an instance method in MyClass

That's called the spaceship operator, it's inside of this method you define what it means to be less than, equal to, and greater than.  But I thought all objects came equipped to deal with equality? so why would i need to do that?

oh I see, in case you are comparing two objects, and you want to directly compare them, not just go into them and grab the values you want to compare

```ruby
class Bid
  include Comparable
  attr_accessor :estimate
  def <=>(other_bid)
    if self.estimate < other_bid.estimate
       # these types of redefinitions must always end in either a positive, negative or zero. and all three should be defined.
      -1
    elsif self.estimate > other_bid.estimate
      1
    else
      0
    end
  end
end
# but here's the other way to write it, the easier way...

def <=>(other_bid)
  self.estimate <=> other_bid.estimate
end
# in the above version, we're piggybacking off of all numerical instances includion of Comparable.
bid1 = Bid.new
bid2 = Bid.new
bid1.estimate = 100
bid2.estimate = 105
bid1 < bi2
```

### How to inspect objects and their methods

`"Hello".methods.sort`

This is one of the simpler methods,  you just ask an objects for its methods in a sorted fashion so you can actually find what you're looking for.

You can also just ask for an object's singleton methods.

`"Hello".singleton_methods`

Even if you define a method later on after an object has been instantiated, if that object is part of the class that received the method, the earlier instantiated object will now have access to that post the fact.

```ruby
str = "Another plain old string"
module StringExtras
  def shout
    self.upcase + '!!!'
  end
end

class String
  include StringExtras
end

str.respond_to? "shout"
# or str.respond_to? (:shout)
# => true
```

Also, you can ask anything what their instance methods are .

`Enumerable.instance_methods.sort`

Also, if you only want to see only one classes instance methods and none of its superclasses instance methods then you can pass false into the method call.

`Enumerable.instance_methods(false).sort`

Other ways to ask a class what its methods are .

```ruby
obj.private_methods
obj.public_methods
obj.protected_methods
obj.singleton_methods

MyClass.private_instance_methods
MyClass.protected_instance_methods
MyClass.public_instance_methods
#this is also a synonym for just straight up instance methods since by default they are public
```
