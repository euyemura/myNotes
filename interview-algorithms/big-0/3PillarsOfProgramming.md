# What is good code?

1. Readable
2. Scalable : There's two things you need to know for these.  Speed is one, how many operations and whatnot.  The next aspect, memory!  In the past, memory was super important.  The CPU generally dictates speed, the RAM, random access memory, dictates memory.

Which code is best?

Answer this with 3 pillars of code.

1. Readable
2. Speed: Time complexity, has a big O time complexity that scales well.
3. Memory: Space complexity, same notation, but different topic.  

With most code solutions, you generally have a trade off between speed and memory. You want more speed, may have to use more memory, and vice versa.

## Space Complexity

When a program executes, it has two ways to remember things, the heap (variables), and the stack (function calls).

Talking about space complexity is similar to time complexity, for a given amount of inputs, how many new variables and how much memory is being used.

Let's think about compression algorithm, O(n).  But there's a certain amount of memory, if we need to create a bunch of new boxes or variables to complete this, it may overflow.

Adding
- variables
- data structure
- function calls
- allocations

Will add to your space complexity.

```ruby
def boo(n)
  boo.each {|bo| puts 'boooo'}
end

boo([1,2,3,4,5])
# time complexity, O(n)
# what about space complexity, O(n)??
```

Ok, for space, we don't care about the input, we care about how much space we are adding in the function..

For our function up above, we are simply creating an i variable, so O(1)

```javascript
function arrayOfHiNTimes(n){
  let hiArray = [];
  for (let i = 0; i< n; i ++) {
    hiArray[i] = 'hi'
  }
  return hiArray;
}

// how about this one?
arrayOfHiNTimes(10)
//[ 'hi', 'hi', 'hi', 'hi', 'hi', 'hi', 'hi', 'hi', 'hi', 'hi' ]
// this space complexity should be O(n).  we're creating an array and adding n amount of items.
```

you're either adding additional space, or data structure, or arrays, in your method, or you're adding more time to your method.

Big O measures what is good code?  Is it scalable, and is it readable, well, readable isn't big O, but big O talks about the scalable part.  

You can save your company a lot of money if you understand this!  I like it. Big O talks about time and space complexity, and we want to talk about worst case scenario.

So, readable, space, time complexity may be more important than the others, in different scenarios.  So, don't do premature optimization.
