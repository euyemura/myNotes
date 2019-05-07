- Encapsulation of behavior in modules
- Modular extension of classes
- The object method-lookup path
- Handling method-lookup failure
- Establishing namespaces with modules and nesting

Modules are kind of like a way in order for you to organize your program.  Breaking big parts into smaller components.

Modules are a bit like Classes, they are bundles of methods and constants. But there are no instances to modules, you simply specify that you want to add the functionality of a module to a class or an object.

Every Class is a direct descendant of a module.  Modules are even more basic than Classes, and classes are just a specialization of modules (aren't these two statements mutually inclusive).   

### How to make a Module

```ruby
module MyFirstModule
  def say_hello
    puts "Hello"
  end
end

class ModuleTester
  include MyFirstModule
end

mt = ModuleTester.new
mt.say_hello
```

You don't instantiate a module, you mix in a module using either `include` or `prepend`.

The benefit of this, is that a class can include as many modules as you want, and then instances of that class will have access to all of those modules.  But you can only inherit from one class.

## A Module Encapsulating 'Stacklikeness'

A modules gives you a way to collect and encapsulate behaviors.

A typical module contains methods connected to a particular subset of what will be the full capabilities of an object.  You want an object to have behaviors related to something, make those a module!

We're going to make a module that acts like a stack.  A `stack` is a data structure that operates on the last in, first out principle.  Like a phsyical stack of plates.  They are usually compared to `queues` which are first in first out.  The quality of being stacklike can manifest itself in a wide variety of collections and aggregations of entities.  

Enter modules.

When you're designing a program and you identify a behavior or set of behaviors that may be exhibited by more than one kind of entity or object, you've probably found a good candidate for a module.  

you wrap it into a module, and then you can summon stacklikeness into any and all classes that need it.  

```ruby
module Stacklike
  def stack
    @stack ||= []
    #@stack unless @stack == nil basically
  end

  def add_to_stack(obj)
    stack.push(obj)
  end

  def take_from_stack
    stack.pop
  end
end
```

```ruby
require_relative 'stacklike'
class Stack
  include Stacklike
end
```

### Difference between require and include

So require and load are both for requiring files, and so they take a string that is the name of the file.

Include and prepend however, generally take a constant as an argument, which is on a file somewhere, so it has nothing to do with files, so yeah.

Look at naming convention, 'Stack objects are stacklike'  The class is a noun, while the module is an adjective.

But we could have just made this a Class in and of itself, however, that defeats the purpose of modeling a certain type of behavior seen in the real world and using it in a multitude of classes and objects.


We can make a suitcase example as well, which we will indeed do.  

`touch cargohold.rb`

```ruby
require_relative "stacklike"
class Suitcase
end

class CargoHold
  include Stacklike
  def load_and_report(obj)
    print "Loading object "
    puts obj.object_id
    add_to_stack(obj)
  end
  def unload
    take_from_stack
  end
end

ch = CargoHold.new
sc1 = Suitcase.new
sc2 = Suitcase.new
sc3 = Suitcase.new

ch.load_and_report(sc1)
ch.load_and_report(sc2)
ch.load_and_report(sc3)
first_unloaded = ch.unload
print "The first suitcase off the plane is..."
puts first_unloaded.object_id

```
## Modules, classes, and method lookup

Objects don't have methods, they find the methods in one of their Classes

```ruby
module M
  def report
    puts "'report' method in module M"
  end
end

class C
  include M
end

class D < C
end

obj = D.new
obj.report
```

As you can guess, even though it's quite a bit of inheritance, the instance of D will indeed have access to the report method.

Interestingly, Object mixes in a module called Kernel, and it is that Kernel that provides Object with most of the methods that it has access to, and thus any object descended from Object will have those methods as well.

If an object and a Module it mixes in both have a same name method, the object will use the one defined in itself, as opposed to the module, if two modules have it, the last one will win.  Just like css.

However, if you use prepend, then the object will look inside of the module first, instead of the class that instantiated it.  

This will change the order when you type in something like, `object.ancestors`

You can use the keyword `super` for navigating a hierarchy of the lookup path.

## Using `super`

```ruby
module M
  def report
    puts "'report' method in module M"
  end
end

class C
  include M

  def report
    puts "'report' method in class C"
    puts "About to trigger the next higher-up report method..."
    super
    puts "Back from the 'super' call"
  end
end
c= C.new
c.report
```

```ruby
class Bicycle
  attr_reader :gears, :wheels, :seats
  def initialize(gears = 1)
    @wheels = 2
    @seats = 1
    @gears = gears
  end
end

class Tandem < Bicycle
  def initialize(gears)
    # the fact that you have gears as an argument means that it's not going to have the default of 1 gear as in its parent class, if you were to delete gears as an argument, then due to super, the gears would have the exact same behavior as its parent and thus it would default to 1. 
    super
    @seats = 2
  end
end
```

## The `method_missing` Method

```ruby
o = Object.new

def o.method_missing(m, *args)
  puts "You can't call #{m} on this object; please try again"
end
o.blah
#custom output
```

### Combine `method_missing` and `super`

```ruby
class Student
  def method_missing(m, *args)
    if m.to_s.start_with?("grade_for_")
      #return the appropriate grade, based on parsing the method name???
    else
      super
    end
  end
end
```

check the person.rb file to look at how we are implementing this.

## Class/module design and naming

Modules don't have instances.  So entities or things are best modeled by classes.  Things that can be instantiated, or things that are replicated in this world.

Remember, a class can only have one direct superclass, so you shouldn't waste it necessarily on something that would better serve as a module, what makes sense in your tree of hierarchy.

You can nest a class inside of a module, which is pretty insane looking.

```ruby
module Tools
  class Hammer
  end
end

h = Tools::Hammer.new
```

Insane.
