# Object Individuation

I think the biggest thing to take away so far is that every object belongs to a class of course, and furthermore, every object also has a singleton class, where one can define singleton methods

`class << object`
Inside a class definition, you could do something like this .

```ruby
class Person
  class << self
    def age
      puts "I am 27 years old"
    end
  end
end
```

If you create a method in a Class' singleton class, then, you've made a class method of course, but any class that inherits from this class, will also be able to access the superclass' singleton class methods!

The fact that you can change Ruby's core behavior is one of the most important aspects of it as a programming language, thus it's important to know when to do so. 
