```ruby
RSpec.describe Card do
  it 'has a type' do
    card = Card.new('Ace of Spades')
    expect(card.type).to eq('Ace of Spades')
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

This is what we have at the moment, some tests and some code that make the tests pass.

```ruby
class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end
```

```ruby
RSpec.describe Card do
  it 'has a type' do
    card = Card.new('Spades', 'Ace')
    expect(card.suit).to eq('Spades')
    expect(card.rank).to eq('Ace')
  end
end
```
Some people think that you shouldn't have more than one expect assertions in a single `it` block, but it is syntactically ok.


```ruby
RSpec.describe Card do
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

But now you have to instantiate the new Card twice.

# Refactoring our Specs, making them DRY
 
