# Context method

```ruby
RSpec.describe '#even? method' do
  it 'should return true if number is even'
  it 'should return false if number is odd'
end
```

This is our baseline, it's ok, but not great.
But in our `it` example block, the string has some conditional logic, an if statement.  What would be better is if we nested our describe blocks.

```ruby
RSpec.describe '#even? method' do
  # it 'should return true if number is even'
  # it 'should return false if number is odd'

  describe "with even number" do
    it 'should return true' do
      expect(2.even?).to eq(true)
    end
  end

  describe "with odd number" do
    it 'should return false' do
      expect(1.even?).to eq(false)
    end
  end

end
```

You can read it like, "even? method with even number?" " it should return true" Get it??

Context is the same thing as describe, but it kind ofis more descriptive.

```ruby
RSpec.describe '#even? method' do
  # it 'should return true if number is even'
  # it 'should return false if number is odd'

  context "with even number" do
    it 'should return true' do
      expect(2.even?).to eq(true)
    end
  end

  context "with odd number" do
    it 'should return false' do
      expect(1.even?).to eq(false)
    end
  end

end
```
