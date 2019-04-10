# Let's talk about the process of problem solving.  

It's not enough just to know algorithms, and it's not just enough about being smart, you need to be able to talk through your process, and talk about your thought process.

Now we'll talk about how to use data structures and algorithms to successfuly solve a coding interview problem

What are companies looking for?

1. Analytical Skills (talk about your thought process while thinking about a problem)
2. Coding skills (clean readable code)
3. Technical Skills (And here I thought your coding skills were your technical skills)
4. Communication Skills

Do all the exercises in the course, and understand the why of all the lessons.

That's what I already do.

## What we need for coding interviews

Data structures

- Arrays
- Stacks
- Queues
- Linked lists
- Trees
- Tries
- Graphs
- Hash Tables

Algorithms

- Sorting
- Dynamic Programming
- BFS + DFS (Searching)
- Recursion

We want to make code that is readable, time efficient, and memory efficient.

### Watching google interview notes....

1.  Write down key points of question.  

He did not do this, but he did reiterate the actual solution they were looking for to make sure that he understood the problem correctly.

2. Make sure you double check inputs and outputs.

So he made sure that the input he was being given could be an array, not ordered necessarily, and should the output be a true or a false, should it return the pair of numbers that make up the array.

He asked if they were integers or floating points, are negatives also a possibility?

He talked about edge cases, can a number be reused to add up to the target sum? The answer was no.   

3. What is most important value, time or space? main goal?

He didn't really talk about this at first.

4. Don't ask too many questions.

He did this, he made sure he knew all the information he needed and then he started.

5. Start with brute force

Yes, he said two for loops could compare every sum to check if there was a sum available.

This is time consuming, as the big O would be O(n^2).

Again, he didnt actually write this code though, he told them about the inefficiency right then and there.

6. Tell them why approach is not good.

He did this well, saying it was quadratic, that it is an O(n^2).

7. Walk through your approach

He then comes up with the binary search possibility, which is much more time efficient.

But that was also too slow, she comes up with possibility to start from both ends.

She asks how is that faster, which I'm not sure.

He asks about what he should return, the pair? a true, a false? A boolean object.

He also talks about an edge case of an empty array being pushed in.

....

Anyways, the example exercise says to describe the nested for loop. And saying that this is not the most efficient, because its O(n^2).  actually, it wouldve been O(a*b). 
