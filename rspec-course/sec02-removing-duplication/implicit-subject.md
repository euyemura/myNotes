```ruby
RSpec.describe Hash do
  let(:my_hash) { {} }
  let(:subject) { Hash.new }
  it 'should start off empty' do
    expect(subject.length).to eq(0)
  end
end
```

`subject` will automatically instantiate what you are talking about.

# Explicit Subject

You can actually edit what the implicit subject will be like shown below. we are just testing the Ruby Hash and here we are editing it.

```ruby
RSpec.describe Hash do
  subject(:bob) do
    { a: 1, b: 2}
  end
  it 'has two key-value pairs' do
    expect(subject.length).to eq(2)
    expect(bob.length).to eq(2)
  end
end

```
