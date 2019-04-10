Say you're working at twitter, and your boss asks you to create a function, you click on a users name, and it should retrieve their latest and oldest tweets.

Well we know we probably have to go through an array of tweets.  

We have to find 1st, and Nth(or the last item)

It could be something like this..

```javascript
const tweets = [{tweet: 'hi', date: 2012},
                {tweet: 'my', date: 2013}, {tweet: 'teddy', date: 2014}]
tweets[0] // O(1)
tweets[tweets.length - 1] // O(1)
// total of O(2) but we reduce constants, O(1)

```

Now he wants you to compare dates of tweets. It sounds like a nested for loop, so maybe O(n^2).  This nested loop could take a lot of time complexity, expensive, so maybe you should store it in a different manner.

`'helaflkjadsfjlkadf'.length` What is the O notation, well it depends, how does the language do it.  could be O(n), but for JavaScript, length is a property, so its just a lookup, it would just be O(1).
