class Person
  attr_accessor :name
end

eric = Person.new
eric.name = "Eric"
matz = Person.new
matz.name = "Matz"
ruby = Person.new
ruby.name = "Ruby"
puts eric.name, matz.name, ruby.name

# if someone wants their name to be secret however, you could do it like this.


# but say multiple people wanted their name to be secret, the best way to dry up this code would be to include a module.

module Secretive
  def name
    "[Not available]"
  end
end

class << ruby
  include Secretive
  p ancestors
end
# or p ruby.singleton_class.ancestors

# p ruby.ancestors this doesnt work, you can only define ancestors on a class I think, or maybe just a singleton_class

puts eric.name, matz.name, ruby.name


# now, if we want to make Matz name secretive, we can just include

# what's happening here is that, you have instance methods defined in the Person class, but, the singleton methods are looked for first, next are modules included in the singleton class, then the class instance methods.
