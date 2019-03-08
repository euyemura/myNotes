- The role of the current or default object, self
- Scoping rules for local, global, and class variables
- Constant lookup and visibility
- Method-access rules

## Self

There is only one self at any given time, but there can be many different selves throughout the lifecycle of a program.

Only one object can be `self` at a given point in time.  

```ruby
class C
  def self.x
    puts "Class method of class C"
    puts "self: #{self}"
  end
end

class D < C
end

D.x

# this will result in self being D, as D inherits the Class methods of C, but it is calling it from D.
```

## Self as the default receiver of messages

check this out, if you know self, you don't have to do the dot notation, but I dunno, it seems a bit confusing and ambiguous.  If you have a variable and a method

```ruby
class C
  def C.no_dot
    puts "As long as self is C, you can call this method with no dot"
  end
  no_dot
end

C.no_dot
```

```ruby
class C
  def x
    puts "this is method 'x'"
  end

  def y
    puts "This is method 'y', about to call x wtihout a dot"
    x
  end
end

c = C.new
c.y

# => This is method 'y', about to call x wtihout a dot.
# => This is method 'x'
```

Remember, self is going to be the intantiated object, so, in y, it's calling self.x, which is c.x, which is indeed a thing.

So we're good!


## Resolving instance variables through Self

Every instance variable you'll ever see in a Ruby program belongs to whatever object is the current object(self) at that point in the program.

```ruby
class C
  def show_var
    @v = "I am an instance variable initialized to a string"
    puts @v
  end
  @v = "instance variables can appear anywhere..."
end
```

Let's expand on this a bit because it's a little confusing.

```ruby
class C
  puts "Just inside class definition block. Here's self:"
  p self
  @v = "I am an instance variable at the top level of a class body."
  puts "And here's the instance variable @v, belonging to #{self}:"
  p @v
  def show_var
    puts "Inside an instance method definition block.  Here's self:"
    p self
    puts "And here's the instance variable @v, belonging to #{self}"
    p @v
  end
end
```

## Determining Scope

If you want a global variable then just put the $ sign in front of the variable name.  Apparently this is generally not a very good practice however, which could explain why it is that I've actually never seen it before just a few days ago.  

This is because using global variables tends to end up being a substitute for solid, flexible program design.  

And again, this is object-oriented programming, you are actually supposed to be looking into objects in order to ask them for the information that they hold.

Don't use global variables, basically.

## Local Scope

- The top level has its own local scope.
- Every class or module-definition block (class, module) has its own local scope, even nested class-/module-definition blocks.
- Every method definition (def) has its own local scope; more precisely, every call to a method generates a new local scope, with all local variables reset to an undefined state.


```ruby
class C
  a = 1
  def local_a
    a = 2
    puts a
  end
  puts a
end

c = C.new
c.local_a
```

## Scope and resolution of constants

If you know the chain of nested definitions, you can access a constant from anywhere, I guess constants have different scope than a local variable.

I can refer to module M, or class M::C, or class C, these are constants, so they're available, as well as any constants that are defined within them.

So in a way, they are global, because they can be accessed anywhere through their chain of nesting, however, a constant X in one self is different than a constant X in a different self.

```ruby
module M
  class C
    class D
      module N
        X = 1
      end
    end
    puts D::N::X
    # you only have to look for it relative to where you are at the current moment, if you were at the top level, then you would have to put in the whole chain of command  
  end
end
```

So this is kind of like the relative path to the constant, however, sometimes you need to refer to things in absolute terms, this is because it may be ambiguous as to which constant you want to find if two have the same name.

```ruby
class Violin
  class String
    attr_accessor :pitch
    def initialize(pitch)
      @pitch = pitch
    end
  end
  def initialize
    @e = String.new("E")
    @a = String.new("A")
  end

  # so right above, we are looking for the Violin::String, not the String default object.

  def history
    ::String.new(maker + ", " + date)
  end
end
# but if we want to create a default string, we use the absolute path, which is double colon in front of the name.
```

## Class variables

Here's something that I am slightly confused about, is it just me or do we not have variables in class definitions, instead, we have instance variables and methods that are only created once things are instantiated, then we also have constants, but is that it?

Class variables are a way to share state between a Class and its instances.  Local variables don't survive the scope change between the Class scope and the object scope that it creates. Globals would, but they are visible everywhere.  And constants aren't it either chief, they must be referenced by the class or module that they were birthed by, but not only this, the whole program can see these constants, it's not private to the Class and the instantiated objects it creates.

So class methods are visible to a class and its instances, class-method definitions and instance method definitions, and sometimes at the top level of the class definition.

Check out `car.rb` to see this in action...

That's actually pretty awesome.

But there are definitely some things to keep in mind when you are using class variables, as a class variable called like, @@make is the same @@make if it's defined in another section of the hierarchy.

```ruby
class Parent
  @@value = 100
end

class Child < Parent
  @@value = 200
end

class Parent
  puts @@value
end
```

So right here, the answer is actually 200, since @@value is the exact same variable between these two, as they are related.  So, you are redefining the same variable once you get into the child.

Also check out `new_car.rb`

 The biggest obstacle to understanding these examples is understanding the fact that classes are aobjects-and that every object, whether its a car, a person, or a class, gets to have its own stash of instance variables. Car and Hybrid can keep track of manufacturing numbers separately, thanks to the way instance variables are quarantined per objects

 ## Deploying Method-Access rules
