# Big O

Big-O asymptotic analysis

Any coder, given enough time, can solve a problem, but how well is that problem solved, how long will it actually take to run, especially considering very large datasets and complex calculations.

## What is good code?

1. Readable: can others understand it
2. Scalable: is it scalable?  Well what does that mean?  That's what big-O can measure for you!.

If you want to bake a cake, you have instructions or algorithms, can your kitchen reliably and quickly handle your instructions, can it work well for an industrial kitchen as well.

```javascript
const nemo = ['nemo']

function findNemo(array) {
  for (let i = 0; i < array.length; i++) {
    if (array[i] === "nemo") {
    console.log(`Found NEMO at the index of ${i}`)
    }
  }
}

findNemo(nemo)
// pretty simple right, it just goes through each element of the array and it compares it to a string of 'nemo'
```

```ruby
nemo = ["nemo"]

def find_nemo(array)
  for count in 0..array.length do
    puts "Found nemo at #{count}" if array[count] == "nemo"
  end
end

find_nemo(nemo)
```

This example here is an instruction to find nemo.  This is the runtime, how long does it take to solve a certain problem through a function or task?

The big O is the efficiency or how long the code takes to run.

### Scalable continued

Let's measure performance of findNemo.

```javascript
const performance = require('perf_hooks').performance;
const nemo = ['nemo']
const everyone = ['dory', 'bruce', 'marlin', 'nemo', 'gill', 'bloat', 'nigel', 'squirt', 'darla', 'hank']

const large = new Array(100).fill('nemo')


function findNemo(array) {
  let t0 = performance.now();
  for (let i = 0; i < array.length; i++) {
    if (array[i] === "nemo") {
    console.log(`Found NEMO at the index of ${i}`)
    }
  }
  let t1 = performance.now();
  console.log("call to find Nemo took " + (t1 - t0) + " ms")
}

findNemo(nemo)
```

```ruby
require 'benchmark'

nemo = ["nemo"]

everyone = ['dory', 'bruce', 'marlin', 'nemo', 'gill', 'bloat', 'nigel', 'squirt', 'darla', 'hank']

large = everyone * 1000

def find_nemo(array)
  time = Benchmark.realtime do
    for count in 0..array.length do
      puts "Found nemo at #{count}" if array[count] == "nemo"
    end
  end
  puts time
end


find_nemo(large)
# 0.6730007000005571,  this took me about 600 ms for 10,000 items
```
When running the benchmark for these, it doesnt really matter if this is one loop or 10 loops, for a computer, this difference is negligible.

WEll with 100, it took 5 milliseconds, then with a 100,000, it takes about 30 milliseconds.

For my repl it took 800 ms.

Again, this depends on how powerful your cpu is, or how fast your coding language is.

Well, if I run my function, and it takes longer than someone running their code on their computer, then does he win? Well, not necessarily, he may have a faster cpu, or he may be using a faster language.

Big o notation is the language we use to run to see how long a language takes to run.

When we talk about scalability, it means when we grow bigger and bigger with our input, how many more operations will we have to do??  Big o allows us to explain this concept.  

Elements or input is on x axis, and operations is on y axis, and different functions have different growth charts, does it rise exponentially, or does it look almost like a straight line?

We can represent this in how long it takes to run, and then how many operations it takes to run.

Lets talk about number of operations in the example down below.  For an array of 100, or 100 elements, we will have 100 operations!  It goes in a linear fashion, that's a for loop, as number of inputs increases, then its operations increases at the same rate.

This means that the notation for this is O(n) --> linear time. n is the number of elements.

for `everyone`, it would be O(10)

O(n) is one of the more common big O notations, and it's performance is fair.  It doesn't run it in seconds, it measures it by how many operations compared to how many elements you entered in.

The big O depends on the number of inputs, n.  The elements in the array for nemo in this example. 

```javascript

const nemo = ['nemo']
const everyone = ['dory', 'bruce', 'marlin', 'nemo', 'gill', 'bloat', 'nigel', 'squirt', 'darla', 'hank']

const large = new Array(100).fill('nemo')


function findNemo(array) {
  for (let i = 0; i < array.length; i++) {
    if (array[i] === "nemo") {
    console.log(`Found NEMO at the index of ${i}`)
    }
  }
}

findNemo(nemo)
```
