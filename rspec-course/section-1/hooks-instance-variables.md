Reducing duplication that we have in our two examples, where we are instantiating a new instance of the Card class multiple times for each `it` block.

A hook is something that runs at a certain point during the time that a test is taking place, the lifecycle of the tests.

Instance Variables: Allow us to persist information that would otherwise be lost.

```ruby
RSpec.describe Card do
  before do
  before(:example) do
  before(:suite) do

  it 'has a suit' do
    card = Card.new('Spades', 'Ace')
    expect(card.suit).to eq('Spades')
  end

  it 'has a rank' do
    card = Card.new('Spades', 'Ace')
    expect(card.rank).to eq('Ace')
  end
end
```

The two befores are the same thing, remember, each it block is an example!

A before block runs before each example, right before each example.



```ruby
RSpec.describe Card do
  before do
    card = Card.new('Spades', 'Ace')
  end

  it 'has a suit' do
    expect(card.suit).to eq('Spades')
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end

end
```

So this is what we can do, we instantiate the object once so we can DRY up our code a bit.

Ok but this failed, because the before block runs before each example, but the instantiated object doesn't actually persist past the before block

You simply have to make it an instance variable.

```ruby
RSpec.describe Card do
  before do
    @card = Card.new('Spades', 'Ace')
  end

  it 'has a suit' do
    expect(@card.suit).to eq('Spades')
  end

  it 'has a rank' do
    expect(@card.rank).to eq('Ace')
  end

end
```

And that works!  Remember, this card isn't being saved once for each example, it's creating a brand new card object before each example is run.

But there are disadvantages of this, if you rename the instance variable, then you'll have to change it in every single instance.

Ruby won't even throw an error, an instance variable that wasn't defined will simply evaluate to nil. It would be better if it threw an error.

# PART TWO: HELPER METHODS TO REDUCE DUPLICATION

The before block runs before each example, however, is this really the most efficient way to do this?

```ruby
RSpec.describe Card do
  # before do
  #   @card = Card.new('Spades', 'Ace')
  # end

  # taking out the before block and adding a helper method.

  def card
    Card.new('Spades', 'Ace')
  end

  it 'has a suit' do
    expect(card.suit).to eq('Spades')
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end
end
```

And that actually works!

There is a disadvantage of this however.

```ruby
class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end
```

Ok so this is our card.  Currently, it is a read only for the methods of suit and rank, so other than instantiation, you won't be able to change what's going on.  Ok got it, if you do something like, `card.suit` and it's just a reader, then you can only return the value of it, you cannot do something like `card.suit = "Diamond"`


```ruby
RSpec.describe Card do

  def card
    Card.new('Spades', 'Ace')
  end

  it 'has a suit and that suit can change' do
    my_card = card
    expect(card.suit).to eq('Spades')
    card.suit = "Diamond"
    expect(card.suit).to eq("Diamond")
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end
end
```

the interesting thing that's going on here, is that we are actually calling the card method three different times, it's not the same card thats being called multiple times.


So what I did there is ok though, I saved it to a variable so it's the same one!

So a good way to think about tests is, you don't want tests to depend on each other at all, instead, assume that every time you ran the test, it ran in a random order, none of them rely on the other.

Across different examples, or `it` blocks, we want different instances of the card.  But on the other hand, it would be nice if we had the same card inside each block, so each time you said card, it didn't recreate that method or instantiate again.

That's where the next method comes in, or the next construct, which is a helper method.

# PART THREE: The Let Method

The whole thing about this method is that in the last method, when we used a helper method in order to create a new instance of the card class each time that we called it in the example block, was that each time card was called, it created a new instance of card, so you can't just be using that.

Memoization == caching.

```ruby
# def card
#   Card.new('Spades', 'Ace')
# end

let(:card) { Card.new('Spades', 'Ace')}
```

So, we are now moving away from the helper method and we are now going to use the let statement.  the `let` syntax is given to us from the rspec gem.

When we `let` the `:card` into existence, we create it as a symbol, however, whenever we reference it later on we are simply going to say `card`

And that `card` is going to evaluate to `Card.new('spades'yasdfasdfasd)`

Three benefits

1. Between `it` blocks or examples, it is instantiating a brand new card, so no pollution can happen.
2. Between a single example, each time you say `card` it will be the same card, it will be cached, so you can change things without being scared that you are instantiating a new card each time.
3. Lazy loading, the let statement will not run until it is called.  So you are not using extra computational power. But, for before, it's action is based on a hook, because that hook runs before every single example, even if the example doesn't use it.  So use let!



So, we dont need this workaround anymore...

```ruby
RSpec.describe Card do

  # def card
  #   Card.new('Spades', 'Ace')
  # end

  let(:card) { Card.new('Spades', 'Ace')}

  it 'has a suit and that suit can change' do
    my_card = card
    expect(my_card.suit).to eq('Spades')
    my_card.suit = "Diamond"
    expect(my_card.suit).to eq("Diamond")
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end
end
```
Instead...

```ruby
RSpec.describe Card do

  # def card
  #   Card.new('Spades', 'Ace')
  # end

  let(:card) { Card.new('Spades', 'Ace')}
  let(:x) { 2 + 2 }
  let!(:y) { x + 10 } #now before every example it'll run, so it's almost the equivalent of the before example.

  it 'has a suit and that suit can change' do
    expect(card.suit).to eq('Spades')
    card.suit = "Diamond"
    expect(card.suit).to eq("Diamond")
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end
end
```

## Custom Error MEssages!

```ruby
RSpec.describe Card do

  let(:card) { Card.new('Spades', 'Ace')}

  it 'has a suit and that suit can change' do
    expect(card.suit).to eq('Spades')
    card.suit = "Diamond"
    expect(card.suit).to eq("Diamond")
  end

  it 'has a rank' do
    expect(card.rank).to eq('Ace')
  end

  it 'has a custom error message' do
    comparison = 'Joker'
    expect(card.rank).to eq(comparison), "Wrong Bitch, I wanted #{comparison} but I got #{card.rank} instead."
  end
end
```

You just need to give the `to` block a second string argument and you will be good to go. 
