# Linked Lists!  

- Singly Linked lists
- Doubly Linked lists

Arrays have limitations, especially for insert and delete operation which would have to change indices, which is O(n).

Hash tables have great insert delete, lookup, but they are not ordered!  

Linked lists of course have their own tradeoffs as well!

## What is a Linked Lists

A singly linked list contains a set of nodes!  A red and green block create a node, you have a value and then a pointer to the next node.  The head is the first node, and the tail is the last node.

Linked lists are null terminated, so, the tail node points to null, which shows you that you are at the end of the list.

They have great insert and delete times, as they dont need to replace indices, they can just point the node to a different direction.  The hard part is finding a specific node because you'll have to iterate through the whole thing.

## Why linked lists?

A con is you must traverse the entire list possibly if you are searching for a specific value.

In a value, with the index, you can get it in constant time.

An array has the upside of having a caching system.  iterating and traversing are slower in a linked list because arrays are much closer together in memory. So they're both O(n), but one each traversal may take longer in a linked list.

The difference in linked lists and hashes is that each node points to the next node, so the data can be sorted in a way.

prepend = O(1)
append = O(1)
lookup = O(n)
insert = O(n)
delete = O(n)

### Pointer

A pointer is a reference to another object or whatever.

```ruby
obj1 = {a: true}
obj2 = obj1
# now any change to object 1 will change object 2.  Obj 2 is simply a pointer to obj1 which is a pointer to the object in memory.
#my mistake, it's not a pointer to obj1, its a pointer to whatever obj was pointing to.
p obj1, obj2
# {:a=>true}
# {:a=>true}
obj1[:a] = "i've evolved"
p obj1, obj2
#[{:a=>"i've evolved"}, {:a=>"i've evolved"}]
```

### Custom linked list


```javascript
const basket = ['apples', 'grapes', 'pears']
// linked list: apples --> grapes --> pears . this is kinda what a linked list looks like.
// let myLinkedList = {
//   head: {
//     value: 10,
//     next: {
//       value: 5,
//       next: {
//         value: 16,
//         next: null
//       }
//     }
//   }
// }

}
//     }
//   }
// };

class LinkedList {
  constructor(value) {
    this.head = {
      value: value,
      next: null
    };
    this.tail = this.head;
    this.length = 1;
  }
  append(value) {
    const newNode = {
      value: value,
      next: null
    }
    this.tail.next = newNode
    this.tail = newNode
    this.length++
    return this
  }
  prepend(value) {
    const newNode = {
      value: value,
      next: this.head
    }
    this.head = newNode
    this.length++
    return this
  }
}

let myLinkedList = new LinkedList(10);
myLinkedList.append(5);
myLinkedList.append(16);
myLinkedList.prepend(22);
```

```ruby
class LinkedList
  def initialize(value)
    @head = {value: value, next: nil}
    @tail = @head
    @length = 1
  end

  def append(value)
    new_node = {
      value: value,
      next: nil
    }
    @tail[:next] = new_node
    @tail = new_node
    @length += 1
    self
  end

  def prepend(value)
    new_node = {
      value: value,
      next: nil
    }
    new_node[:next] = @head
    @head = new_node
    @length +=1
    self
  end
end

my_list = LinkedList.new(10)
```

prepend: O(1)
append: O(1)
lookup: O(n)
insert: O(n)
delete: O(n)

So far we have coded prepend, and append, but lets code the others as well.

```javascript

class LinkedList {
  constructor(value) {
    this.head = {
      value: value,
      next: null
    };
    this.tail = this.head;
    this.length = 1;
  }
  append(value) {
    const newNode = {
      value: value,
      next: null
    }
    this.tail.next = newNode
    this.tail = newNode
    this.length++
    return this
  }
  prepend(value) {
    const newNode = {
      value: value,
      next: this.head
    }
    this.head = newNode
    this.length++
    return this
  }

  printList() {
    const array = []
    let currentNode = this.head
    while (currentNode !== null) {
      array.push(currentNode.value)
      currentNode = currentNode.next
    }
    return array
  }

  insert(index, value) {
    const newNode = {
      value: value,
      next: null
    }
    let currentNode = this.head
    for (let i = 0; i < index; i++) {
      currentNode = currentNode.next
    }
    newNode.next = currentNode
    currentNode = newNode
    length++
    return this
  }
}

let myLinkedList = new LinkedList(10);
myLinkedList.append(5);
myLinkedList.append(16);
myLinkedList.prepend(22);
```

```ruby
class LinkedList
  attr_reader :head, :tail, :length
  def initialize(value)
    @head = {value: value, next: nil}
    @tail = @head
    @length = 1
  end

  def append(value)
    new_node = {
      value: value,
      next: nil
    }
    @tail[:next] = new_node
    @tail = new_node
    @length += 1
    self
  end

  def prepend(value)
    new_node = {
      value: value,
      next: nil
    }
    new_node[:next] = @head
    @head = new_node
    @length +=1
    self
  end

  def insert(index, value)
    new_node = {
      value: value,
      next: nil
    }
    current_node = @head
    index-1.times do
      current_node = current_node[:next]
    end
    new_node[:next] = current_node[:next]
    current_node[:next] = new_node
    @length += 1
    self
  end

  def delete(index)
    preceding_node = find_preceding_node(index)
    preceding_node[:next] = preceding_node[:next][:next]
    @length -= 1
    to_s
  end

  def find_preceding_node (index)
    correct_index = index - 1
    preceding_node = @head
    correct_index.times do
      preceding_node = preceding_node[:next]
    end
    preceding_node
  end

  def to_s
    array = []
    current_node = @head
    while (current_node)
      array << current_node[:value]
      current_node = current_node[:next]
    end
    array
  end
end

my_list = LinkedList.new(10)
my_list.append(20)
my_list.prepend(40)
my_list.append("hello")
p my_list.to_s
my_list.insert(2,2)
p my_list.to_s
my_list.insert(2,"te nexewst")
p my_list.to_s

```

## Doubly Linked Lists

Each node that isn't the head as two pointers, one to the next node, and then pointing back to the previous node.  This of course doesn't apply to the head.

This allows you to traverse the list backwards.

```ruby
class LinkedListDouble
  attr_reader :head, :tail, :length
  def initialize(value)
    @head = {value: value, next: nil, previous: nil}
    @tail = @head
    @length = 1
  end

  def append(value)
    new_node = {
      value: value,
      next: nil,
      previous: nil
    }
    new_node[:previous] = @tail
    @tail[:next] = new_node
    @tail = new_node
    @length += 1
    self
  end

  def prepend(value)
    new_node = {
      value: value,
      next: nil,
      previous: nil
    }
    new_node[:next] = @head
    @head[:previous] = new_node
    @head = new_node
    @length +=1
    self
  end

  def insert(index, value)
    new_node = {
      value: value,
      next: nil,
      previous: nil
    }
    current_node = @head
    index-1.times do
      current_node = current_node[:next]
    end
    new_node[:next] = current_node[:next]
    new_node[:previous] = current_node
    current_node[:next] = new_node
    @length += 1
    self
  end

  def delete(index)
    preceding_node = find_preceding_node(index)
    preceding_node[:next] = preceding_node[:next][:next]
    preceding_node[:next][:previous] = preceding_node
    @length -= 1
    to_s
  end

  def find_preceding_node (index)
    correct_index = index - 1
    preceding_node = @head
    correct_index.times do
      preceding_node = preceding_node[:next]
    end
    preceding_node
  end

  def to_s
    array = []
    current_node = @head
    while (current_node)
      array << current_node[:value]
      current_node = current_node[:next]
    end
    array
  end
end
```
