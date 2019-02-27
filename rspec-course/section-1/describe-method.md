# The Describe Method

1. Create a file in your spec folder

`touch card_spec.rb`

2. `RSpec.describe('Card')`

We will describe what it is that we are testing, it accepts an argument.

The card keyword describes an example group.  This organizes a group of related tests. A test is also called an example.  So an example group is a group of tests

```ruby
RSpec.describe 'Card' do
  #example group, this is where you write all of your tests
end
```

# The `It` Keyword

```ruby
RSpec.describe 'Card' do
  #example group, this is where you write all of your tests
  it 'has a type' do
  end
end
```

`it` is a method, we put it in the body of the block of the describe method, and it also takes an argument, a sentence that describes a feature that we will describe.

You describe the expected behavior. Don't go implementation specific, like, it will use an array or a hash to do this.  So, not how it's built, but what it's going to do. That's for inside the `it` block in the expectations.

It goes over the behavior of the card, all these its will live within the describe.

# The 'expect' and 'eq' methods

```ruby
RSpec.describe 'Card' do
  #example group, this is where you write all of your tests
  it 'has a type' do
    card = Card.new('Ace of Spades')
    expect(card.type).to eq('Ace of Spades')
    expect(1 + 1).to(eq(2))
  end
end
```

Inside of the expect parenthesis can be almost anything, an object, a method, a plain ruby expression, an attribute of an argument, not sure if it can just be a variable.

eq makes a == like thing, this eq(2) is the argument you give to `.to`

Each `expect` statement is called an 'assertion'

# Running the Tests

In the directory in which your tests and ruby code reside, you can simply run `rspec` and you will be fine.

But this will run your whole suite of tests, instead you can run the specific test.

`rspec spec/card_spec.rb`

So I don't think that you can put multiple expect statements, or assertions, into a single `it` block.  As soon as I put the math one in a different `it` block it worked.

Well, perhaps you can have multiple expects in an  `it` block, as since it fails at the naming of it you don't even get to your expect assertions.

Each `it` method creates one example, so in ours, we have 1 example and 1 failure of that example.

# Now we make the tests Pass!

Remember, don't fix all the errors at once, fix one error and then the next and so on.  That's TDD

```ruby
class Card
end
```

But this class doesn't expect any arguments, so we have to make room for some arguments

```ruby
class Card
  def initialize(type)
  end
end
```

```ruby
class Card
  attr_reader :type

  def initialize(type)
  end
end
```

```ruby
class Card
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
```

# REFACTOR

`RSpec.describe 'Card' do` The string of 'Card' is acually not doing anything at all.  It's just a string, so we can change it to this to actually show that Card is a class.

`RSpec.describe Card do`

When you are more specific about the example group that you are testing, between just a random string of 'Card' and then the meaningful class of Card, you actually get some helper methods from RSpec that will shorten the amount of code that you have to write in the future. 
