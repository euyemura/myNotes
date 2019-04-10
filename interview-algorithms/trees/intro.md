# Trees

They usually have a single root node, and it's a hierarchical structural, as opposed to link lists and arrays which are linear.

Ever child descends from a root node, and every child can only have one one parent, but each child can have multiple children.

Our HTML DOM (document object model) are all trees.

A linked list is a tree, but just having one path, and there's only one direction and one path.

A node can only point to a child, and the children don't necessarily refernce their parent.

## Main trees

Binary Tree: Each node can only have 0,1,2 children. And each child, can only have one parent.  

A perfect binary tree is very efficient.  Each child has two children  for same number of levels.

Because of this structure, we get, O(log N)

lookup: O(logN)
insert O(logN)
delete: O(logN)

Level O: 2^0 = 1
Level 1: 2^1 = 2
Level 2: 2^2 = 4
Level 3: 2^3 = 8

This is how you calculate the number of nodes in a perfectly balanced binary tree.

IF this were an array, it would be an array of 8.

# of nodes = 2^h - 1;
log nodes = steps (or height, starting at 1)


log nodes = height
log 100 = 2 because 10^2 = 100

Log N is like looking through a phone book, divide and conquer until you get to that person. ITs great because you don't need to check every element, there is logic in how you iterate over every single element.

### Binary search tree (subset of a binary tree which we just went over)

Lookup: O(log N)
Insert: O(log N)
Delete: O(log N)

It has an advantage over a hash because there are relationships, there's a parent child.  Just like your directories on a computer.

All child nodes to the right of the current node, must be bigger than the current node.

A node can only have up to two children. It's great for finding a certain item.  

O(log N) is a bit slower than O(1), a hash allows you to delete in constant time.

A problem with BST is that you can have unbalanced search tree, that turns into a link list, and all of a sudden, a search will be O(n)

Pros and cons of BST

Pros
- Better than O(n)
- Ordered
- Flexible Size

Cons
- NO O(1) operations!

## Binary Heaps

Every node is bigger than the nodes below it. Lookup is still O(n), but insert and delete are O(logN)

They are great at doing comparitive operations, if you want all elements bigger than a certain number.

Binary heaps are very quick, they preserve order of insertion.  
