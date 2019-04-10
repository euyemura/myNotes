# Arrays

Arrays are sometimes known as lists, that are stored sequentially.

They have the least amount of rules, and thus, they have the smallest footprint.

`lookup` O(1)
`push` O(1) ==`push`, unless....  javascript actually looped over every item, copied them, and put them somewhere else, with the last item added, it would now be O(n), not O(1)
`insert` O(n)
`delete` O(n)

```ruby
strings = %w{a b c d }
# each letter takes up a byte, so this would take 4 bytes, which is 32 bits.
# he basically says that every individual thing takes up 4 bytes, 32 bit system.
strings[2]
# 'c'
strings.push('e')
# ["a", "b", "c", "d", "e"]
# O(1), no matter how long, we just add it to the end of it.
strings.pop
# 'e', O(1), just removing last item. because it knows where it is stored.
strings.unshift('l')
#["l", "a", "b", "c", "d"]
# O(n), it's an insert, every item has to shifted over 1 index, thus you have to iterate over all of them.  In pop. no other index is changed. So, it's O(n).
# Arrays may thus not be the best data structure for adding an element to the beginning of the array.
```

Static v dynamic arrays

Well for JavaScript, we don't have to think about memory, we don't need to specify how long an array will be, but in C++ because you have to do this low level stuff, everything is more specific, so it's faster.

Copying the array would be low level...

Arrays

Pros
- Fast lookups
- Fast push/pop

Cons
- Slow inserts
- Slow deletes
