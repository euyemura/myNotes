# Algorithms

Basically any function is an algorithm, it's just steps that you dictate in a computer program. They're literally just directions.

Data Structures + Algorithms = Programs

Algorithms

- Sorting
- Dynamic Programming
- BFS + DFS (Searching)
- Recursion

Certain algorithms allow us to take bad Big O time complexities to smaller time complexities.  Large companies handle a lot of data, and thus scaling their programs is super important.

## Recursion

Recursion isn't really an algorithm, it's more of a concept!

What is recursion? If you look at a computer, and you want a file, you must look through all files recursively.

`ls -R` looks through all files in all folders and lists them.

You define something in terms of itself, it's a function that refers to itself inside of the function.

```ruby
def inception
  inception
end
```

How does it help us solve problems?  When there's repeated subtasks, recursion is great.  

## Stack Overflow

Pouring water into a glass, well, if you don't tell it to stop, you'll get a stack overflow.

That's one of the bigger problems in recursion, you need to know how to stop it.  And also, every time you call the function, it'll need to allocate memory, so the more times it called, the more memory you are using.

## Anatomy of Recursion

Either you call the function again, or you hit the base case, where there is a condition wher eyou stop.

```ruby

counter = 0
def inception(count)
  return 'done' if (count > 10)
  count += 1
  inception(count)
end

```

```ruby
def find_factorial_recursive(number)
  return number if number == 2
  number * find_factorial_recursive(number -1)
end

def find_factorial_iterative(number)
  product = number
  while number > 1
    number -= 1
    product *= number
  end
  return product
end

def factorial(number)
  array = []
  while number >= 1
    array << number
    number -=1
  end
  array.inject(:*)
end

def factorial(number)
  array = []
  for index in 1..number
    array << index
  end
  array.inject(:*)
end
```

```ruby
# FIBONACCI SEQUENCE!

def fib_recursive(number)
  return 1 if number == 1
  return 0 if number == 0
  return fib_recursive(number - 1) + fib_recursive(number - 2 )  
end
# O(2^n)

def fib_iterative(number)
  return 0 if number == 0
  return 1 if number == 1
  starter = [0,1]
  for fib in 2..number do
    starter[fib] = starter[-1] + starter[-2]
  end
  starter.last
end

fib_iterative(5)
```

Recursion is O(2^n), which is way worse than O(n^2)

Anything that can be done recursively, can be done with loops!

There are times when recursion can keep your code DRY! It can make your code more readable!

It does create a large memory footprint, because every time it calls itself, it adds to the call stack.

Iterative approaches are generally more efficient, but maybe less readable.

Recursion is great when you don't know how many loops you're going through, particularly with tree data structures.

## When to use recursion?

When it gets to complicated problems, like traversing through trees, then recursion is great, and even better than iterative approaches.

When using a tree, or converting to a tree, then maybe use recursion.

1. A problem can be divided into subproblems which are smaller instances of the same problem.
2. Each instance of the subproblem is identical in nature.
3. The solutions of each subproblem can be combined to solve the problem at hand.

Divide and conquer using recursion!
