# Learn Ruby

First we need to make a new branch to test out any new features we make.

1. `git checkout -b rails-flavored-ruby`

Ok, for the first example let's look at a line in the application layout file.

`<%= stylesheet_link_tag 'application', media: 'all',
                                       'data-turbolinks-track': 'reload' %>`

So apparently there are four potentially confusing ruby ideas going on here.

1. built-in Rails methods
2. method invocation with missing parentheses.
3. Symbols.
4. Hashes.

## Custom Helpers

We're going to create our own custom helper.  

`<%= yield(:title) %> | Ruby on Rails Tutorial Sample App`

Basically, every static page needs to have provided a title for this line to work in the application layout file. like so .

`<% provide(:title, "Home") %>`

So, it's probably a better idea to create this using a helper, because a helper can have the logic in order to allow for a base title when no title is provided.

Aite, so where do we put this helper?

WELL. In the 'helpers' directory, we have an application helper and a static pages helper.  So, I believe that because we are going to be using this helper inside of the 'application' layout, we should put it in the application helper.  

Here is the helper in all its glory

```ruby
def full_title(page_title = '')
  base_title = 'Ruby on Rails Tutorial Sample App'
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end
```

And here is how we call it in the application layout file.

`<title><%= full_title(yield(:title)) %></title>`

## Strings and methods

So, you know how for special characters you sometimes have to escape them in order to get them to print correctly, with single quotes, you don't need to do that, it prints everything literally.  YOu will have to escape characters in the double quotes though, since they give you extra functionality.

## Back to the helper

Remember that we are working with a module here.  Modules need to be mixed in, you do this by explicitly `include Module` inside your class or whatever, this gives the object access to all the methods of the module.

The beautiful thing about this is that rails does this for you, thus the module is available in all of our views, as it is in the application helper.

## Arrays

So we have lots of array methods, like `arr.sort` but these won't mutate the actual array, in order to do that, you can simply add a bang.

`arr.sort!` now arr will be permanently changed.

## Range

`0..9`
`(0..9).to_a`

```ruby
a = %w[foo bar baz quuz]
a[0..2]
# ["foo", "bar", "baz"]
# a trick to return every element
a[0..-1]
```

Awesome

Check out this shorthand for an array method map.

```ruby
%w[A B C].map(&:downcase)
# => ['a', 'b, 'c]
```

## Hashes

```ruby
user = {} #i've just instantiated a fresh new Hash
user["first_name"] = "Eric"
user["last_name"] = "Uyemura"
user

# or you can write it this way.

user = { "first_name" => "Eric", "last_name" => "Uyemura" }
```

A  lot of times however, the key for a hash will be a symbol.

```ruby
user1 = { :name => "Eric Uyemura", :email => "test@example.com" }

user2 = { name: "Eric Uyemura", email: "test@example.com" }

user1 == user2
# true
```

When you perform `each` on a hash, it expects two block variables.

```ruby
flash.each do |key, value|
  puts "Key #{key.inspect} has value #{value.inspect}"
end
```

Curious though why they have to do inspect.

## With our new knowledge of hashes and symbols!

`<%= stylesheet_link_tag 'application', media: 'all',
                                       'data-turbolinks-track': 'reload' %>`

That is equal to this...

`stylesheet_link_tag('application', { media: 'all',
                                   'data-turbolinks-track': 'reload' })`

As we can see here, we're calling a function and giving it arguments, a few of which are key value paris.

So, a hash is the last value of the argument, because of this we do not need to put in the curly braces.

## Class inheritance

Check out this pretty awesome example of class inheritance.

```ruby
class Word
  def palindrome?(string)
    string == string.reverse
  end
end
```

This makes way more sense though.

```ruby
class Word < String
  def palindrome?
    self == self.reverse
    # same as self == reverse , because if no object is specified it automatically defaults to self
  end
end
# now you can do a bunch of other methods .

s = Word.new("level")
# you can instantiate it like a string, there is no muddling of methods since Word just has one instance method that doesn't really interact with any other String method.
s.palindrome?
s.length

```

So this is good, but we can do better by adding the method to the String class itself, remember that we can always reopen a class.

```ruby
class String
  def palindrome?
    self == reverse
  end
end
```

The crazy thing is, if you go to the
