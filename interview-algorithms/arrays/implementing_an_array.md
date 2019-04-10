1. How to build One
2. How to Use it

```ruby
class My_Array
  attr_reader :length
  def initialize (length = 0)
    @length = length
    @data = {}
  end
  def get(index)
    @data[index]
  end
  def set(item)
    @data[@length] = item
    @length += 1
  end
  def pop
    popped_item = @data[@length - 1]
    @data.delete (@length - 1)
    @length -= 1
    popped_item
  end

  def delete(index)
    deleted_item = @data[index]
    shift_items(index)
    @length -= 1
    deleted_item
  end

  def shift_items(index)
    for i in index..(@length - 1) do
      @data[i] = @data[i + 1]
    end
    @data.delete(@length -1)
  end
end

```

Remember, when we are deleting, it forces us to loop over the entire array. 
