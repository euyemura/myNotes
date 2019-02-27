```ruby
class King
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

RSpec.describe King do
  subject { King.new('Boris') }
  let(:louis) { King.new('Louis')}
end

```

What if in this situation, you are asked to change the name of the class King, to Royal.  Well, we do not have to hardcode the value of King, instead, we can do this...


```ruby
class King
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

RSpec.describe King do
  subject { described_class.new('Boris') }
  let(:louis) { described_class.new('Louis')}
end

```

# One Liner Syntax

```ruby
class King
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

RSpec.describe King do
  subject { described_class.new('Boris') }
  let(:louis) { described_class.new('Louis')}

  it "represents a great person" do
    expect(subject.name).to eq('Boris')
    expect(louis.name).to eq('Louis')
  end

  it { is_expected. }
end

```
