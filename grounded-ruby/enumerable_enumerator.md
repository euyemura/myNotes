# Collections central: Enumerable and Enumerator

- Mixing `Enumerable` into your classes
- The use of `Enumerable` methods in collection objects
- Strings as quasi-enumerable objects
- Sorting enumerables with the `Comparable` module
- Enumerators

When you mix in `Enumerable` into a class, that class must have an `each` method, remember that many of those collection methods are based upon the each method.

Then you have the `Enumerator` class, this gives even more iteration logic to a class.

## Gaining enumerability through `each`

IF you mixin `Enumerable` you must have an `each` method that yields items to a supplied code block one at a time.

The way each works for each class is a bit different.  For an array, it yields each element successively.  In a hash it yields key value paris in the form of two element arrays.

Here's a sample proof of concept.

```ruby
class Rainbow
  include Enumerable
  def each
    yield "red"
    yield "orange"
    yield "yellow"
    yield "green"
    yield "blue"
    yield "indigo"
    yield "violet"
  end
end
r = Rainbow.new
r.each do |color|
  puts "#{color} is quite nice, very niceeee"
end

# Now that we have defined an each method, we have access to a bunch of other Enumerable instance methods, we have fulfilled the only requirement for using that method.

y_color = r.find do |color|
  color.start_with? ("y")
end

puts "The first color to start with the letter \"y\" is #{y_color}"
```

Are you interested in all of the instance methods that `Enumerable` endows you with?

`Enumerable.instance_methods(false).sort`

## Enumerable Boolean Queries

These are  `Enumerable` methods that return true or false based on whether the query they were looking for results in a match.  Here's something

```ruby
# Assuming we have an array of states.

states.include?("Louisiana")
# true
states.all? {|state| state =~ / /}
# false : this tests if all states include a space.
states.any? {|state| state =~ / /}
# true: i think you can guess this one.
states.one? {|state| state =~ /West/ }
# is there one and only one state with the word West in it.
states.none? {|state| state =~ /East/ }

```

How about using these methods with hashes

Well, with hashes, you have access to the key and the value!

```ruby
states.include?("Louisiana")
# true, and include only checks for the key, not the state abbreviation value.
states.all? {|state, abbr| state =~ / / }
# false
states.one? { |state, abbr| state =~ /West/ }
# true, one and only one state with the word west.
states.keys.all? { |key| }
```

You see here that we are giving a code block with they key and the value as block variables. We don't have to do that.
You can just pass one value and it will be represented as an array  of two values, the keys and the hash
`hash.each {|pair|}`

How about for ranges??

Well ranges basically act like arrays, however, if the first item in a range is a float, many of the `Enumerable` methods will not work, otherwise, they are the same.  If the last item in the range is a float however, everything will work fine and the item will simply be rounded down.

## Enumerable searching and selecting

`find`: will return the first element that meets your criteria. You pass it the key and value for a hash.

`select` :also has a bang version that will keep all the elements that meet the criteria.

`reject` : pretty much the same but the exact opposite.

### Selecting on threequal matches with grep

Remember, the === will check to see if the thing on the right is part of the thing on left, including being an instance of, if its a range then it will check if its within that range

```ruby
colors = %w{ red orange yellow green blue indigo violet }
colors.grep(/o/)

miscellany = [75, "hello", 10...20, "goodybye"]
miscellany.grep(String)
miscellany.grep(50..100)
```

Grep is basically the same as this `enumerable.select { |element| expression === element }`

Grep can also take a block, which essentially maps over the selected array that is a result of the `grep(expression)`

```ruby
colors.grep(/o/) { |color| color.upcase }
```

### Organizing selection results with `group_by` and `partition`

This one is pretty cool, based on kind of code block you give it, it'll give you back either a hash with each value being an array that matched that group, or for parition, an array of two arrays where the first array is true and the second is false.

```ruby
colors.group_by {|color| color.length }
# {3=>["red"], 6=>["orange", "yellow", "indigo", "violet"], 5=>["green"], 4=>["blue"]}
colors.partition {|color| color.include? "o"}
# [["orange", "yellow", "indigo", "violet"], ["red", "green", "blue"]]

sort_arr = [["red", 1], ["red", 2], ["red", 1], ["red", 3], ["blue", 3],  ["blue", 0], ["blue", 1], ["blue", 2], ["blue", 1], ["blue", 0], ["green", 3], ["green", 0], ["green", 2], ["green", 1], ["green", 3], ["red", 0]]

[["blue", 0], ["blue", 0], ["green", 0], ["red", 1], ["red", 1], ["blue", 1], ["blue", 1], ["green", 1], ["red", 2], ["blue", 2], ["green", 2], ["red", 3], ["green", 3], ["green", 3]]

[["blue", 0], ["blue", 0], ["green", 0], ["red", 1], ["red", 1], ["blue", 1], ["blue", 1], ["green", 1], ["red", 2], ["blue", 2], ["green", 2], ["red", 3], ["blue", 3], ["green", 3], ["green", 3]]

[["blue", 0], ["blue", 0], ["green", 0], ["red", 0], ["red", 1], ["red", 1], ["blue", 1], ["blue", 1], ["green", 1], ["red", 2], ["blue", 2], ["green", 2], ["red", 3], ["blue", 3], ["green", 3], ["green", 3]]

class Person
  attr_accessor :age
  def initialize(options)
    @age = options[:age]
  end

  def teenager?
    (13..19) === age
  end
end

people = 10.step(25,3).map { |i| Person.new(age: i) }
split_people = people.partition {|person| person.teenager? }.flatten(1)
split_people.map {|person| puts "Hello, I am a person and I am #{person.age} years old"}
```

## Element wise enumerable operations

### The first methods

`first` will return the first element, if its a hash it'll return the first key value pair.

`last` is present for `Array` and `Range`, it's not present for a `Hash`

### Take and drop methods

`take` will return you with however many elements from the beginning of the Enumerable that you specified.
`drop` will also take those elements, but it will return you all the other elements following those that were taken.

```ruby
states = %w{ NJ NY CT MA VT FL }
states.take(2)
states.drop(2)
states.take_while {|s| /N/.match(s) }
states.drop_while {|s| /N/.match(s)}
# these will take the things that meet the condition, but it has to be at the beginning of the array, or else you will just get nil.
```
### The `min` and `max` methods

So, min and max use the <=> operator to determine what the min and max are. In the case of a string, it'll go by their character number, and remember, lowercase is greater than uppercase.  In the case of an integer, its obvious.  but you can always customize this to go off whatever you want.

```ruby
languages = %w{ Ruby C APL Perl Smalltalk }
languages.min
# APL
languages.min_by { |lang| lang.size }
# now we are deciding how we want this to measure the minimum or the maximum
languages.minmax
# this'll give you an array of the largest and the smallest, and you can also do minmaxby
```

## Relatives of each

`reverse_each` each but in reverse... lol.

`each_with_index` works for arrays and hashes, but apparently is somewhat deprecated,

`each.with_index`

`each_slice` will divide the array into slices of whatever value you pass into it and then you give it a code block.

`each_cons` is similar, but goes through the array one by one and then makes the arrays of whatever size you deem worthy.

### The `cycle` method  

`cycle(1)` each but the integer argument you put in there will do the each however many times you have specified.

### Enumerable reduction with inject

`inject` = `reduce`

`[1, 2, 3, 4].inject(0) {|acc,n| acc + n}`

Will do something with the sum of all the parts.

## Map
```ruby
names = %w{ Eric Yukihiro Chad Amy}
names.map {|name| name.upcase }
names.map(&:upcase)
```

`map` also has a bang version `map!` which will obviously mutate the original array. The destructive version is only available on arrays, since map always returns an array, it wouldn't make sense to

## Strings as quasi collections

`each_char`
`chars`
Pretty much all you need to know.

## Sorting

In order to sort, you must define the `<=>` operator.
```ruby
def <=>(other_painting)
  self.price <=> other_painting.price
end
```

This allows you to sort, but it doesn't allow you to do the `<=` OR `>=` operations, you still have to `include Comparable` in order to get that functionality.

You can override this if a <=> is already defined or you can define it by giving the sort a block, here's something building upon the last example.

```ruby
year_sort = [pa1, pa2, pa3, pa4].sort do |a,b|
  a.year <=> b.year
end
```

### How about `sort_by`

```ruby
["2", 1, 4, "3", 5, "4", 6, "1", 9].sort_by {|el| el.to_i }
# I think you just specify what you want to sort it by, in terms of each element.  tahts why in my example, i called the variable a pair, because each element was an element of two, and i specified that in the context of that pair, i wanted the last one.
```

## Enumerators and the next dimension of enumerability

Enumerators are closely related to iterators. An iterator is a method that yields values to a code block, an enumerator is not a method, but an object.

An enumerator is basically an `enumerable` object.  It has an each method, and it mixes in the `Enumerable` module to define all the usual methods -select, inject, map et al.

However, an enumerator is not a container object, the `each` method of the enumerator is built very differently then a collection object.

You must specify the `each` method yourself in one of two ways.

1. Call `Enumerator.new` and pass it a code block that tells it how to do each.  
2. You build your enumerator on top of an already enumerable object (array, hash, range). You 'hook up' an enumerator to an iterator on another object.

```ruby
e = Enumerator.new do |y|
  y << 1
  y << 2
  y << 3 # this is not an append, it's telling the object what the each method will be iterating over, i think. i dunno.
end
