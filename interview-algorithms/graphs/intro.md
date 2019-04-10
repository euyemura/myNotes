# Graphs

One of the most useful and used data structures in real life.  It is a set of values that are related in a pair wise fashion.

Each item is a node, and they have edges, which link to other nodes.  WHen things have many relationships, like a web of knowledge, or a web of networks, then you use graphs.

Or even to replicate maps and whatnot.

## Types of graphs

A tree is a graph, even a linked list is.

- Directed: Can you only move one way?
- Undirected: Can you move in any direction on any edge?

- Weighted graph
- Unweighted graph: the edges can have numbers, maybe that represent a distance, to calculate the fastest path for example.

Directed Acyclic graph is a popular graph.

```ruby
# this is an edge list, just showing all connections.
graph = [[0,2], [2,3], [2,1], [1,3]]  

# adjacent list, each index represents a node, and the numbers inside of it are the connections from the node to the rest of the edges. 
graph = [[2], [2,3], [0,1,3], [1,2]]
