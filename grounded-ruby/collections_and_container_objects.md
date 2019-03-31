- Sequentially ordered collections with arrays
- Keyed collections with hashes
- Inclusion and membership tests with ranges
- Unique, unordered collections with sets
- Named arguments using hash syntax

Ruby implements collections principally through the technique of defining classes that mix in the Enumerable module.  

Remember, collections are just objects, you send them methods just like any other object, they just have an extra dimension beyond the scalar.

## Arrays and hashes in Comparison

Arrays are ordered, in that each element inside of them is indexed, you can put anything inside of an array.

Hashes are also ordered, which is a recent addition.  They store objects in pairs,  a key and a value.  You retrieve a value by means of the key.  Keys are unique per hashes, you can only have one value for any given key.  

Again, hashes have an index, well its like they have two, the key, and then the index that ruby keeps track of, arrays only have their numerical index.

```ruby
hash = { "red" => "ruby", "white" => "diamond", "green" => "emerald" }
hash.each.with_index {|(key, value), i| puts "Pair #{i} is #{key}/#{value}"}
# Pair 0 is red/ruby
# Pair 1 is white/diamond
# Pair 2 is green/emerald
hash.each.with_index {|key, i| puts "Pair #{i} is #{key}"}
# Pair 0 is ["red", "ruby"]
# Pair 1 is ["white", "diamond"]
# Pair 2 is ["green", "emerald"]
# this makes me think that any iteration thing can have the .with_index syntax added at the end which is pretty awesome.
```

When you iterate over a hash, you need a space for the key and for the value, thus the comma separated list. Otherwise, you would just get back an array of two items, the key, and the value, and you would have to use the array notation in order to access each of those, not the end of the world.

## Collection Handling with Arrays

### Creating a new Array

You have a literal constructor which is the `[]` method, or the other one, `yadayada = Array.new`

```ruby
a = Array.new
# you then have to actually set the values manually
Array.new(3)
# [nil, nil, nil]
Array.new(3, "abc")
# ["abc", "abc", "abc"] each of these strings are actually the same object in memory, so changing one would change all of them.  Here's an alternative way to do that
Array.new(3) { "abc" }

n = 0

Array.new(3) { n += 1; n * 10}
# [10, 20, 30] damn thats pretty crazy not gonna lie.
```
```ruby
string = "A string"
string.respond_to?(:to_ary)
# false
string.respond_to?(:to_a)
# false
Array(string)
#["A string"]
def string.to_a
  split(//)
end
Array(string)
#["A", " ", "s", "t"...etc]
```

#### The `%W` and `%W` Array Constructors

```ruby
%w{ David A. Black }
# [ "David", "A.", "Black"]
%w{ David\ A.\ Black is a Rubyist. }
# ["David A. Black", "is", "a", "Rubyist."] also these are all techinically single quotes, you should use them the capitol if you wnat double quoted strings.  
%W{ David is #{2014-1959} years old.}
# ["David", "is", "55", "years", "old"]
```

### Getters and setters in arrays

So we all know the original notation for setting specific indexes for arrays, but what is really going on behind the scenes.

Of course whenever we are using something like the + operator, we're really calling a method that is kind of just dressed up as something else using some syntactic sugar. `3.+(3)`

Similarly, when we say something like `my_arr[0] = "first element"` it's really `my_arr.[]=(0, "first element")` it's actually just a setter method.  

```ruby
a = [1, 2, 3, 4, 5]
p a[2] # == a.[](2)
```

You can give any of these notations a second argument, the first tells you which element you're accessing, but the second argument will tell you how may arguments you want to actually access, to get or set.

```ruby
a = ["red", "orange", "yellow", "purple", "gray", "indigo", "violet"]
a[3,2]
# ["purple", "gray"], as we can see, it's starting at the index of 3 and grabbing two elements
a[3,2] = "green", "blue" # a.[]=(3,2,["green", "blue"])
a
# ["red", "orange", "yellow", "green", "blue", "indigo", "violet"] this does the same thing, but actually sets those elements
```

#### The Slice Method

The slice method is basically like the [] access notation, it takes 2 arguments, the second being an optional length for how many elements that you want to grab. And the bang version removes the elements permanently.  Another interesting method is the `values_at` method, which will take as many arguments as you want, and will return an array with the elements at the indexes that you gave to it.

```ruby
arr = ["red", "green", "blue", "orange"]
arr.values_at(0, 2, 3, 18) # ["red", "blue", "orange", nil]
arr = ["red", "green", ["blue", "dog"], "orange"]
arr.values_at(0, 2, 3, 18)
# it appears that you can't access a nested array this way.
```
#### Special methods for manipulating the beginnings and ends of arrays

Adding elements to the beginning or the end of an array, `unshift` (like, shift would be moving something, but unshift would be not doing that) and `push`

`array.unshift(3)` now 3 is the first element of the array.
`array.push(3)` now 3 is the last element.  It can also take multiple arguments
`array.push(3, "hello", [1, 2])`
`array << 3` This operator can only push in one element however,

The opposite methods would be `shift` and `pop`, i'm pretty sure they should be able to take an argument of however many elements you want to take off. They return whatever element was removed, and they are also mutators.


I think they are all mutators, they change the actual original array.

### Combining Arrays with other arrays

```ruby
int_arr = [1, 2, 3]
int_arr.concat([4, 5, 6])
# the important thing to note about concat is that it needs to be given an array, and push does not, it can just take a list.
int_arr.replace(["hello", "goodbye"])
# replace and concat both need to be given actual arrays, not lists. and replace replaces the actual array, not just the reference that the variable points to, so this is important if you have multiple variable pointing to the same array in memory, if you replace one variable, then all the rest will be changed as well, again, this is different than reassignment
```

### Array transformations

`flatten`: no matter how many levels deep you have nested arrays, flatten will actually just make them all a one dimensional array completely, you can give an integer argument to flatten it however many levels deep that you want, the higher the number, the flatter it will become. There is a bang version of this method.

`reverse`: There is also a bang version of this method.

`join`: turns it into a string...

`arr = [[1, 2], {abc: "hola"}]`
`arr.join` "12{:abc=>\"hola\"}"

`*` is basically the same as join
`arr * ", "`

`.uniq` will give you a new array with all duplicates removed. it also has a bang version which will permanently remove those duplicates from the original array.

`.compact` will remove all nil instances in a new array, but you can also use the bang version to change the original array.

### Array Querying

`a.length`
`a.empty?` returns true if the array is empty of any elements
`a.include?(item)` true if the array includes the item you are querying for
`a.count(item)` counts the number of instances of a given item
`a.first(n=1)` you can pass in however many items you want and get an array of those back, if you pass in 1 literally, it will give you it back in array form.
`a.last(n=1)`
`a.sample(n = 1)`

## Hashes

The key and the value can be any kind of object you want, can they be true false or nil though??? Yes true, false, or nil can be hash keys.  if multiple keys have the same name, then only the last one will be kept, each key must be unique, which kinda makes sense.

```ruby
state_hash = { "Connecticut" => "CT",
               "Delaware"    => "DE",
               "New Jeresey" => "NJ" }
print "Enter the name of a state: "
state = gets.chomp
abbr = state_hash[state]
puts "The abbreviation is #{abbr}"
```
Why use a hash, it provides quick lookup in better than linear time. They do remember their order and will respect that when you iterate over them.

### Creating a `new` hash

- With the literal constructor
- With the Hash.new method: `Hash.new` you can provide an argument that will be the default value for nonexistent hash keys, as opposed to nil Im assuming. Yes it by default defaults to nil.
- With the Hash.[] method, don't pass in an odd number of arguments unless you want an error.
```ruby
Hash["Connecticut", "CT", "Delaware", "DE"]
#  {"Connecticut"=>"CT", "Delaware"=>"DE"}
Hash[ [ [1,2], [3, 4], [:a, "hello there"]] ]
# {1=>2, 3=>4, :a=>"hello there"}
```
- With the top-level method whose name is Hash: Not important

### Inserting, retrieving, and removing hash pairs

```ruby
state_hash["New York"] = "NY"
state_hash.[]=("New York", "NY")

state_hash.store("New York", "NY")

state_hash.fetch("Connecticut") # "CT", if you try to lookup a nonexistent key, it'll raise an error as opposed to giving you the default value.to avoid this, add in a second argument.
state_hash.fetch("New Zealand", "Not true")
# getting multiple values in a hash and saving them in an array.
two_states = state_hash.values_at("New Jersey", "Delaware")
# ["NJ", "DE"]
```

### Specifying Default hash values and behavior

To specify a default value for a nonexistent key, you must use the `Hash.new` method.
```ruby
h = Hash.new("hola")
h["i dont exist"] # returns "hola"
```

This doesn't actually create a key called "i dont exist", if you want to do that, you must give it a code block.  

```ruby
h = Hash.new { |hash, key| hash[key] = "hello world!"}
h["I was never really here"] # = "hello world"
h # {"I was never really here"=>"hello world!"}
```

### Combining hashes with other hashes

There's two types, the nondestructive type, where a third new hash is created, and the destructive type, where the hash who had the method called is permanently changed in that it has had a second hashes contents added to it.

The destructive way = `update` if the second hash has a identical key as the first one, then the first one will have it's original value updated, get it.  if you want a new hash made, you can go ahead and use the `merge` method, the bang version of merge is actually the exact same thing as the update method.

### Hash Transformations

#### Selecting and Rejecting Elements from a hash

`select` : you call this method and pass it a code block, if the key value pair passes the test of the block, it will be included in the returned hash . `select` and `reject` both have bang versions.

```ruby
h = Hash[1, 2, 3, 4, 5, 6]
h.select { |key, value| key % 3 == 0 }
# {3=>4}
h
# {1=>2, 3=>4, 5=>6} the original hash in left unchanged.
h.reject { |key, value| key % 3 == 0 }
# {1=>2, 5=>6}
h
# {1=>2, 3=>4, 5=>6} the original hash in left unchanged.
h.select! { |key, value| key % 2 == 0 }
# {}
h
# {}
h.reject! { |key, value| key % 2 == 0 }
# nil
h
# {1=>2, 3=>4, 5=>6}
```

Hash#invert will flip the keys and the values, but if you have more than one value that is identical, only one will be kept, as hash keys must be unique. It is not a mutator

Hash#clear will empty the hash and it is a mutator.

Hash#replace is a mutator and you must pass it a hash, not just a list, or wait, when a hash is the last value of a method call aren't you able to nix the curly brackets. Indeed, as long as you use the hash rocket syntax, you do not need the curly brackets, actually i must've done something wrong, it accepts the colon format as well.

### Hash Querying

```ruby
h.has_key? (1) # returns true if the hash has a key of integer 1
h.include?(1) # this is the same as has_key?
h.key?(1) # another synonym for has_key?
h.member?(1) # another synonym for has_key? dafuk...

### testing for values
h.has_value? "three" #returns true if any value is "three" what if it jsut includes the string "three", no it has to include the exact value.
h.value?  "three" #another synonym
h.empty? # true if there are no key value pairs inside of the hash h
h.size # counts the number of key value pairs
```

`has_key?` and `has_value?` are the most popular of these!

### Hashes as final method arguments

There's not much to say for this, no curly brackets necessary when you have a hash as last argument.

#### If you have a named keyword, you can save a step when a hash is a method argument.

```ruby
def m(a:, b:)
  p a,b
end

m(a: 1, b: 2)

# adding defaults
def m(a: 1, b: 2)
  p a, b
end

m(a:10)
# 10
# 2


```

## Ranges

- Inclusion: does a given value fall within a range
- Enumeration: The range is treated as a traversable collection of individual items

The two dot version is inclusive of the last number, the three dot version is not .

```ruby
r = Range.new(1,100)
r = 1..100 # these two are synonymous
r = 1...100
r = Range.new(1,100, true) # now this one is exclusive, just like the three dot version

# You can also check the beginning and ending numbers within a range.
r.begin
r.end

# Here's one way to check whether a range is inclusive or exclusive of it's range .

r.exclude_end?
```

### How to check whether a range includes a certain value

```ruby
r = "a".."z"
r.cover?("a")
r.cover?("abc") # this is aninteresting one, it's true, lets check if they have to be in order. it doesn't matter what order they are in. in the case of integers, you can also use a range within the cover? arguments section.  

# now lets test include?

r.include?("a") # true
r.include?("abc") # false this is different than above, because its kind of testing each letter individually like an array, instead of however they do it with cover.
```

## Sets

In order to use this, just like the Date class, you must require it as it is a standard library class, not a part of the core class.

`require 'set'`

A set is a unique collection of objects.  The objects can be anything, but each object must be unique.  "hello" is a different object than "hello" in memory, but that doesn't matter within the set. Any two objects that would count as identical keys would be counted as duplicates within a set as ewll.

### Set creation

`Set.new`

```ruby
new_england = ["Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont"]
state_set = Set.new(new_england)
```

There is no literal constructor for the set, as it is a part of the standard library, and the core is loaded before the standard library.  

Passing each item through a code block.

```ruby
names = ["Eric", "Yukihiro", "Chad", "Amy"]
name_set = Set.new(names) { |name| name.upcase }
```

It appears that set is already required within irb, so no need to do that.  Also, a float is different than the integer version of that float, like 1 and 1.0 can both be included in the set.

### Manipulating Set Elements

```ruby
name_set << "Arjuna"
name_set.delete("Chad")
name_set.add?("Arjuna") # returns nil as opposed to original set if it already exists. Youd do this if you want to test whether it was successful.
```

You can add subtract and use the `&` operator between sets in order to do operations on multiple sets, you can also merge collections into sets.
