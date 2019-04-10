# Hash tables

Hashes and arrays are the most popular data structures for interview questions.

Javascript = objects; python = dictionaries; ruby = hashes!

Arrays have index and value, hashes have keys and values.

`basket.grapes = 10000`

Key = grapes
The key is used as the index of where to find the value in memory.

This is done with a hash function.  We pass grapes into the blackbox (hash function), and it stores the key and value into a memory location.  

## Hash Function

A hash function is something used all against computer science, it generates a value of fixed length for any input.  It turns a value into a bunch of gibberish.  You can really only do it in one direction

But the same input will always result in the same output, but you can't necessarily use that output to find the input.  

This gives us fast data access.  If we pass the same input, or hash key, into the hash function, then it'll make the gibberish, and convert that into the index space in memory.  

Every time you add a property, or retrieve a property, you must use the hash function.  This hashing function is super quick, so lookup is quite quick.

The time complexity of the hash function is O(1), super fast.

## Hash Collisions

Insert : O(1)
Lookup : O(1)
Delete : O(1)
Search : O(1)
Because none of the hash keys depend on the other keys, any of these operations only take constant time.

```ruby
user = {
  age: 54,
  name: "Kylie",
  magic: true,
}
user[:age] # 54 O(1)
```

```javascript
let user = {
  age: 54,
  name: "Kylie",
  magic: true,
  scream: function() {
    console.log("ahhhh")
  }
}

user.age //O(1)
user.spell = 'abra kadabra'; // O(1)
user.scream(); // O(1)
```

There's always pros and cons of any data structure, even hash tables.

There can be hash collision. Two key value pairs are stored in same address space.  It creates a link list.  With many collisions, it'll slow down your speed, it can become O(n/k), because you have to iterate through every element at the same memory space.

To deal with collisions, you can use linked lists like he showed us, but there's many other ways.

## Hash tables in different languages

In JavaScript, we can use a function as a value or a key, but in ruby, you can't do this.  As a method is not an object.

JavaScript also has maps and sets that are different kinds of hash tables, but hash tables nonetheless.

```javascript
//create own hash table.
class HashTable {
  constructor(size){
    this.data = new Array(size);
  }

  _hash(key) {
    let hash = 0;
    for (let i =0; i < key.length; i++){
        hash = (hash + key.charCodeAt(i) * i) % this.data.length
    }
    return hash;
  }

  set(key, value) {
    let address = this._hash(key)
    if (!this.data[address]) {
      this.data[address] = [];
    }
      this.data[address].push([key, value])
  }

  get(key) {
    let address = this._hash(key)
    const currentBucket = this.data[address]
    if (currentBucket) {
      for (let i = 0; i < currentBucket.length; i++) {
        if (currentBucket[i][0] === key)
        return currentBucket[i][1]
      }
    } else {
      return undefined
    }
  }

  keys() {
    let keys_arr = []
    this.data.forEach ( bucket => {
      if (bucket) {
        for (let i = 0; i < bucket.length; i++) {
          keys_arr.push(bucket[i][0])
        }
      }
    })
    return keys_arr
  }
}

const myHashTable = new HashTable(50);
myHashTable.set('grapes', 10000)
console.log(myHashTable.get('grapes'))
myHashTable.set('apples', 9)
console.log(myHashTable.get('apples'))
console.log(myHashTable.keys())
```

So, hash tables are great when you want quick access for specific values.  Because hash functions are so quick, whenever you are looking for something specific, you can search, insert, lookup, delete, and whatever at a constant speed.

In arrays, order matters, so inserting and deleting can cause you to have to reiterate over many elements in order to keep the order correct. And searching, you have to search over the whole array, if you search a specific key, you get it almost instantly inside of a hash table.

This is why hashes are so great for databases.

Although there is collision, we don't really have to worry about this too much.

Because in arrays, each value is placed close to each other in memory, we are able to retrieve large amounts of information faster!
```ruby
# given an array = [2,5,1,2,3,5,1,2,4]
# //Given an array3 = [2,1,1,2,3,5,1,2,4]:
# //It should return 1
#
# //Given an array2 = [2,3,4,5]:

# def find_first_recurring_character(array)
#   char_hash = {}
#   array.each do |el|
#     if char_hash.has_key? el
#       return el
#     else
#       char_hash[el] = true;
#     end
#   end
#   return nil
# end

arr = [2,5,5,1,2,3,5,1,2,4]
array3 = [2,1,2,3,5,1,2,4]
array2 = [2,3,4,5, 4]

def find_first_recurring_character(array)
  char_hash = {}
  array.each { |el| char_hash.has_key?(el) ? return el : char_hash[el] = true }
  return nil
end

find_first_recurring_character(arr)
find_first_recurring_character(array3)
find_first_recurring_character(array2)
```

Pros

They are fast lookups, fast inserts, flexible keys.

* The one thing to think about would be having collisions.

cons

Unordered, slow key iteration.

The trade off is faster access, but more  memory. 
