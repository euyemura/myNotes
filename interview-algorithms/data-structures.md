# Data Structures

A data structure is a collection of values, algorithms are the processes we implement to manipulate these structures.

Data Structures + Algorithms = Programs

These are all universal principles, because underneath any program we have data and something to manipulate data.

## What is a data Structures

Every data structure is useful in certain situations, they are each specialized for certain tasks.

You can think of each data structure as a different kind of container, and each container specializes in holding certain types of things.  You put clothes in a suitcase, you put files in a file folder, you put food in a fridge, you put tools in a tool case, etc.

Every programming question has a trade off, readability, memory, or speed.  Each data structure has similar trade offs.

1. How to build a data structure.
2. How to use it.

We really just want to know when to use one or the other.  That's number 2, because in Ruby at least they're already made. Array, Hash, Range, Set.

## How Computers Store Data

- CPU : CPU is the calculating part, it uses the storage and the RAM, the RAM is much faster to access.
- RAM : This is where variables are stored. This is temporary, you lose it when the program or computer is stored off.
- Storage : Video files, music files, documents, solid state drive, a disk.

Google chrome, has lots of code, our CPU is the thing that actually powers that.  Where does your computer choose to hold the memory.

RAM is a massive storage area, it has shelves that are numbered, they're addresses, it's a huge shelf.  It allows you to run programs. Each shelf holds 8 bits, each bit is either a 1 or a 0, each shelf of 8 bits is called a byte. A bit is a tiny electrical switch that can turn on or off.

The CPU is connected to a memory controller that reads and writes to the shelves. CPU asks memory controller to read out what's on shelf 0, or the 10,000th shelf.  The connections are all established beforehand, which is why the more RAM you have the faster your computer is.  The closer your data is to each other on each shelf means faster computing.  

The CPU also can save small amounts of info into it's cache to even more speed up information.

But what does this have to do with data structures?   

```javascript
var a = 1;
```

This would take up 32 bits, or 4 bytes.  The more bits you have access to, 64-bit vs 32-bit, the more complicated your data structures can be.

Depending on the data structure, they may be located close to each other or far from each other in the shelves.

Each individual data value is stored as one or more bytes, a collection of 4 bytes is generally called a word, but maybe 8 bytes, or 64 bits is getting more common.

A letter can take up one byte, 8 bits.

An integer can be one word, or 4 bytes, 32 bits. Thus, the integer 12,345 would also take up one word, or 4 bytes.

A float can be two words, or 8 bytes, or 64 bits.

Data structures

- Arrays
- Stacks
- Queues
- Linked lists
- Trees
- Tries
- Graphs
- Hash Tables

What about data types though?

Integers, strings, booleans, nil, etc.  

## Operations on Data Structures

What are the various operations that can be performed on data structures?

Data structures are ways to organize data, how do we manipulate these? Some are good at certain types of operations, like insertion.

Insertion: Just adding a new item.

Deletion: Deleting an item.

Traversal: Go through every data item in a structure.

Searching: Find a specific data item.

Sorting: Sort it.

Access:  Maybe most important, how to get into it.
