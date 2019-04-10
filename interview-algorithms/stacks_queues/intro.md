# Stacks and Queues

They are both linear data structures, in which you iterate through all of the elements one by one!

You generally just work with the elements at the first and last element. Why use something like this?  

You can build them using arrays and linked lists, but then you get limited operations.  That means you control what are the right operations on your data structure.

## Stacks

Stacks are like plates, its last in first out!

`lookup` O(n)
`pop` O(1)
`push` O(1)
`peek` O(1)

Great for knowing the last value that are seen.  

Browser history uses stacks.  Going back and forward through things is a stack.  You store previous state of memory such that the last one comes back first.

## Queues

Like an entrance to a rollercoaster, FIFO.
So it's the oppposite of the stack.

`lookup` O(n)  We dont want to lookup values in the middle of the queue.
`enqueue` O(1)  push
`dequeue` O(1)  shift
`peek` O(1)   tells you first person to come out of the last.

Ubers, waitlists, printers, it's always the first one that enters the line is the first one that gets the result.

You don't want to build this with an array, because when you shift an item, you have to change all indices of everything else.  This isn't the same for stacks. 
