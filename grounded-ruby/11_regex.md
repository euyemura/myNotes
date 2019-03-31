# Regular Expressions and regexp-based string operations

- Regular Expression Syntax
- Pattern-matching operations
- The MatchData Class
- Built-in methods based on pattern matching

A regular expression specifies a patter of characters that may or may not predict a given string, or match a string.

In ruby, regular expressions are objects, and you send messages to these regex objects.  Regex objects can also be sent as arguments to strings.

Many built-in ruby methods take regular expressions as arguments, so I wonder if regex objects both take arguments and are given away as arguments.

Use regex to match a string and possibly do something to that string afterwards, and not just do something to the original string but simply to take some sort of action if the string does or does not match with your regex.

### Simple matching with literal regular expressions

All regex expressions are instantiated from the `Regexp` class and they do have a literal constructor for easy instantiation, a pair of forward slashes, `//`

`//.class`

So the whole basis for regex is a relationship between the regex and the string, and different methods that say something or assert something about that relationship.

`match` method is one way to check this.

And you can write this in either direction, either as the strings method or as the regex method.

```ruby
puts "Match!" if /abc/.match("The alphabet starts with abc.")

puts "Match!" if "The alphabet starts with abc".match(/abc/)
```

In these examples the 'abc' has to be subsequent and I i'm sure case matters.

When you use `match` if there is a match you get a `MatchData` object, whereas if you don't get a match it returns `nil`

```ruby
puts "Match!" if /abc/ =~ "The alphabet starts withabc" # now i'm putting it within a word to see if it still matches.
puts "Match!" if "The alphabet starts with abc" =~ /abc/
# these both work.
```

Instead of a `MatchData` object, we will get returned a an index of where the match was found.

## Building a pattern in a regular expression

The components of a regex.

- Literal characters, meaning "match this specific character"
- The dot wildcard character(.) meaning "match any character" (except \n)
- Character classes, meaning "match one of these types of characters"

### Literal characters in patterns

`/a/` will match any string that has the letter 'a' inside of it.   This works pretty simply, however, there is a group of special characters that you must escape if you want to match their literal expression.

`/\?/` is one example, where we want to match a '?' but not its special meaning.

Group of special characters: ^$?./\[]()+*

### The dot wildcard (.)

This will match literally any character, so an empty string will not do. Yes an empty string will not do. It'll match anything but a newline `\n`

`/.ejected/` will match rejected,dejected, bejected, sejected, whatever.

### Character classes

A character class is an explicity list of characters placed inside the regexp in square brackets.

`/[dr]ejected/`  So this regex will match either 'dejected' or 'rejected' but nothing else. and anything inside of the square brackets will only result in one character.

`/[a-z]/` Will match any lowercase characters
`/[A-Fa-f0-9]` this will match any hexicdeciaml digit!

You can also negate a certain amount of characters so they don't match.

`"g"/[^A-Fa-f0-9]` This will match, as g is not included in that regex.

 now it cannot be a hexidecimal digit whatever is inside of here.

 Do you want to find the first occurrence of a non hexidecimal value???

 ```ruby
 string = "ABC3934 is a hex number"
 string =~ /[^A-Fa-f0-9]/
 # 7 because a space is the first index of a non hexdec number.
 ```

 Some character classes are so common that there are shortcuts for them.

 `/[0-9]/` == `/\d/`
 `/\w/` matches any digit, letter, or underscore.
 `/\s/` matches any whitespace character, space, tab or newline.

You can do the opposite of these just by capitalizing the letter.

`/\D/` == `/[^0-9]/`

## Matching, substring captures, and MatchData

So say you have a long string, and it has a predictable format, you can make a regex that'll match that string, and also capture certain subsections of that string, as shown below.

```ruby
# "Peel,Emma,Mrs., talented amateur"
# First some letters, then a comma, then some more letters, then another comma, then either mr or mrs, then a comma, then a talent.
/[A-Za-z]+,[A-Za-z]+,Mrs?\./ # this is our regex, it takes any amount of letters, then a comma, then any amount of letters, then a Mr with or without an 's' as shown by the questionmark, and then a period, which must be escaped.
# so how do we capture the subsections, just put a parenthesis aruond them.
/([A-Za-z]+),[A-Za-z]+,(Mrs?\.)/.match "Peel,Emma,Mrs., talented amateur"
# #<MatchData "Peel,Emma,Mrs." 1:"Peel" 2:"Mrs.">
# as you can see, we have a match object, and then what kind of looks like a hash but not sure.
# now the are saved in global variables, and you can see them like this,
p $1, $2
matcher.string # results in the whole matched string being called back.
puts "Dear #{$2} #{$1}," # thats pretty awesome, from that you can generate a salutation.
```

### Match Success and Failure

Matches create a `MatchData` object, otherwise it results in nil, here's how to find a phone number, random I know.

```ruby
string = "My phone number is (123) 555-1234"
my_phone_re = /\(\d+\)\s\d+-\d+/
phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/
# so thats how you specify the amount of characters.
m = phone_re.match(string)
unless m
  puts "there was no match-sorry"
  exit
  #this will exit the program if there was no match.
end
print "The whole string we started with: "
puts m.string
print "the entire part of the string that matched"
puts m[0]
puts "The three captures: "
3.times do |index|
  puts "Capture ##{index + 1}: #{m.captures[index]}"
end
puts "Here's another way to get at the first capture:"
print "Capture #1: "
puts m[1]

# The whole string we started with: My phone number is (123) 555-1234
# the entire part of the string that matched: (123) 555-1234
# The three captures:
# Capture #1: 123
# Capture #2: 555
# Capture #3: 1234
# Here's another way to get at the first capture:
# Capture #1: 123
```

### Two ways of getting the captures

You can get the captures by directly indexing the MatchData object array style.

`m[0] # is the entired matched section`
`m[1] # is the first part of the capture`

`m.captures` is an array where the first index is the first capture, not the entire matched object.

When trying to figure out which index will be at which capture point in the array, make sure to just count from the opening parenthesy on the left.

#### Named captures

```ruby
re = /(?<first>\w+)\s+((?<middle>\w\.)\s+)?(?<last>\w+)/
# check this one out, you can put a parenthesy around the whole thing in order to sy it may or may not be there, it can represent one expression, or it can represent a capture group, or maybe its the same thing.  anyways, a question mark followed by <> will produce an easy key for you to grab.
name = "Eric A. Uyemura"
m = name.match re
m[:first]
```

### Other MatchData information

```ruby
# this is adding on to the phone example.
print "The first part of the string before the part that matched was: "
puts m.pre_match
print "The part of the string after the part that was matchd was: "
puts m.post_match
print "The second capture began at character "
puts m.begin(2)
print "The thrid capture ended at character "
puts m.end(3)
```

`begin` is inclusive of the first index, and `end` is exclusive

You can also enter in the symbols of the named captures into the begin and end methods.  

## Fine-tuning regular expressions with quantifiers, anchors, and modifiers

### Quantifiers

They work on a single character or a parenthetical group.  

`Mrs?\.?/` This means zero or one 's' and zero or one '.' which must be escaped!

`*` means zero or more!

`+` one or more!

These are all greedy operators, they will keep on looking over the string until they get to the point where the regex no longer matches.  So /\d+/ will keep on matching as long as there are numbers.

`+?` will match only until the least condition is met, same with `*?`

Remember, greedy matchers will be greedy up until the  point that they can still match whatever they are looking for, so, match first, then greed.  Here's an example.

```ruby
string = "Digits-R-Us 2345"
/(\d+)(5)/.match(string)
# #<MatchData "2345" 1:"234" 2:"5">
```

So what's happening in the above example?  First off, we have two parenthetical groups, or two capture groups, This is simply to see what we are capturing.

As you can see from the output, we have our matched string which is the 2345, and then e have the two capture groups, the greedy + capture will only match as many characters as it can such that the entire regex will be able to match!

#### Specific number of repetitions

```ruby
/\d{3}-\d{4}/
```

This will match something like a phone number, 3 digits - 4 digits no spaces.  

`/\d{1,10}/` This one is matching anywhere from 1-10 digits!  

`/\d{3,}/` This is matching 3 or more digits in a row.

Here's an interesting gotcha with parenthetical groups, or capturing a specific number of an atom, which is a parenthetical subpattern or character class.

```ruby
/([A-Z]){5}/.match("Eric UYEMURA")
# #<MatchData "UYEMU" 1:"U">
```

So, why would that capture gorup only grab the U? it's because the character class range is only designed to capture one letter, we're just doing it 5 times, so we are only saying to capture one letter, which will default to the last letter.. If we want the whole then make sure to get your parenthesis right.

```ruby
/([A-Z]{5})/.match("Eric UYEMURA")
#  #<MatchData "UYEMU" 1:"UYEMU">
/([A-Z]{5,})/.match("Eric UYEMURA")
# #<MatchData "UYEMURA" 1:"UYEMURA">
```

### Regular expression anchors and assertions

So we have been talking about characters, which imply consuming a character in the string you are matching.

An assertion or an anchor don't consume characters, they express constraints or conditions that must be met before a match can occur, or before the consuming will happen.  So a matcher matches a character, an assertion or anchor gives the context of when it will matched pretty much..

`^` beginning of line, this is different than the negation, which must happen inside the square brackets of a character class `[^a-g]`.  

`$` end of line

Here's an example that shows how to use the beginning of line anchor to match any comments...

```ruby
comment_regexp = /^\s*#/
comment_regexp.match("   # a comment")
# #<MatchData "   #">
comment_regexp.match(" x = 1 # code plus comment")
# nil
```

It only works if the optional whitespace and the comment are at the beginning of the string.

Here's a list of anchors, not all of them.

`^` beginning of line.
`$` end of line
`\A` Beginning of string
`\z` End of string
`\Z` End of string(excepft for final newline)
`\b` Word boundary `/\b\w+\b/` "!!!word*** (matches "word")"

### Lookahead Assertions

```ruby
str = "123 456. 789"
m = /\d+(?=\.)/.match(str)
#  #<MatchData "456">  as you can see, no dot is matched
```

Ok so, this looks a bit confusing. first we are matching at least one digit, then the lookahead assertion is the `?=` the character we are looking ahead for is the `\.` the period, which must be escaped, and then its in parenthesis, which means that it should not be included in the match.  

`?=` is a positive lookahead, means it must be there,
`?!` is a negative lookahead, which means it can't be there.

```ruby
str = "123 456. 789"
m = /\d+(?!\.)/.match(str)
#  #<MatchData "123"> as you can see, we have a negative lookahaed, which is any number of numbers NOT followed by a dot.
```

### Lookbehind Assertions

```ruby
re = /(?<=David )BLACK/
# this will only match if BLACK is preceded by David
re = /(?<!David )BLACK
# this will only match if its not preceded by David.
```

Non-capturing parenthesis
`(?:...)` Anything inside this grouping will be matched based on the grouping, but not saved to a capture group.

```ruby
str = "abc def ghi"
m = /(abc) (?:def) (ghi)/.match(str)
# #<MatchData "abc def ghi" 1:"abc" 2:"ghi">
m[0] # "abc def ghi"
m.string # "abc def ghi"
m.captures # ["abc", "ghi"]
```
#### Conditional Matches

If a capture was or was not found, then either one of two other captures will be matched.

```ruby
re = /(a)?(?(1)b|c)/
re.match("ab")
# #<MatchData "ab" 1:"a">
re.match("b")
# nil, it won't match b because capture number one was not matched.  
re.match("dc")
#  #<MatchData "c" 1:nil> it will match c because capture number one was not matched.
```

### Modifiers

A modifier is a flag, a letter placed after the final forward slash of the literal constructor for a regex that doe s something.

`/abc/i` this means that it will now be case insensitive.

`m` flag will match anything including new lines.

```ruby
str = "This (including\nwhat's in parens\n) takes up three lines."
m = /\(.*?\)/m.match(str)
# the question mark makes it non greedy, I don't think it would have changed anything in this case though. Yes it doesnt change anything in this case.
# below it would tho.
str = "This (including\nwhat's in parens\n) ok) takes up three lines."
m = /\(.*?\)/m.match(str)
# #<MatchData "(including\nwhat's in parens\n)">
m = /\(.*\)/m.match(str)
# #<MatchData "(including\nwhat's in parens\n) ok)">
# now it matches everything in parens.
```

`x` modifier will not include any whitespace unless you escape it in your pattern, this lets you add comments to your regex to explain what it is indeed doing.

## Converting strings and regular expressions to each other.

I guess you can convert them.  

### String-to-regexp idioms

```ruby
str = "def"
/abc#{str}/
# now the regex is /abcdef/
str = ".ef"
/abc#{str}/
# now we have a wildcard character, but we can escape it so it acts as just a period.
Regexp.escape(".ef")
# "\\.ef"  double slash because it has to escape the escape...
re = /abc#{Regexp.escape(str)}/
# /abc\.ef/
Regexp.new('(.*)\s+Black')
# /(.*)\s+Black/
```

### Going from a regular expresssion to a string

```ruby
puts /abc/
# (?-mix:abc)
/abc/.inspect
# "/abc/"
```

## Common Methods that use regular expressions

Now we're going past match!

```ruby
array.find_all {|str| str.size > 10 && /\d/.match(e)}
```

### String#scan

The scan method goes from left to right in a string, testing for a match with a pattern that you specify, the results are returned in an array.

```ruby
"testing 1 2 3 testing 4 5 6".scan(/\d/)
# ["1", "2", "3", "4", "5", "6"]
"testing 1 2 3 testing 4 5 6".scan(/((\d\s\d)+)/)
# [["1 2", "1 2"], ["4 5", "4 5"]]
```

```ruby
str = "Leopold Auer was the teacher of Jashca Heifetz."
regex = /([A-Z]\w+)\s+([A-Z]\w+)/
violinists = str.scan regex
#  [["Leopold", "Auer"], ["Jashca", "Heifetz"]]
str.scan regex do |fname, lname|
  puts "#{lname}'s first name was #{fname}"
end
# Auer's first name was Leopold
# Heifetz's first name was Jashca

"one two three".scan(/\w+/) do |number|
  puts "next number is #{number}"
end

# next number is one
# next number is two
# next number is three
#  => "one two three"
```

### String#split

```ruby
line = "first_name=david;last_name=black;country=usa"
record = line.split(/=|;/)
#["first_name", "david", "last_name", "black", "country", "usa"]
```
### sub/sub! and gsub/gsub!

`sub` will just change one part of a string, whereas `gsub` will change all the instanced in a string.  

#### Single substitutions with sub

`sub` takes two arguments, a regexp (or a string) and a replacement string.

```ruby
"typigraphical error".sub(/i/, "o")
#  "typographical error"
```
Interestingly enough, you can also give a code block to do something to whatever thing that you matched, which is pretty awesome.

Lets try to capitalize the second word in a string.

```ruby
str = "the horse drank water"
re = /\s+\w+/
str.sub(re) {|match| match.upcase}
# "the HORSE drank water"
```

This couldve been easier, as the parenthetical groups are available for use inside the block.

```ruby
str = "i cant concentrate"
re = /\w+\s+(\w+)/
str.sub(re) {|match| $1.upcase}
# "CANT concentrate"
```

the rough thing about this way is that it replaces the entire matched string, not just the parenthetical group that i targeted.

#### Now using gsub

This will replace all the matched instances of the string.

If you want to upcase the first letter in every word here's a cool way to do it.

```ruby
"capitalize every word".gsub(/\b\w/) {|s| s.upcase }
# "Capitalize Every Word"
```

#### Using the captures in a replacement string

You just need a backslash in front of the number of the capture group.

```ruby
"aDvid".sub(/([a-z])([A-Z])/, '\2\1')
# "David"
```
We use single quotations because this allows us to only have to escape the backslashes once instead of double backing.

```ruby
"double every word".gsub(/\b(\w+)/, '\1 \1')
# "double double every every word word"
```

#### Case equality and grep

For regexp, `===` is the same as `.match`.
`re === string` But this won't give you a Matchdata object like match will, and it won't give you an index like =~ will, instead it will just give you true or false, not sure if it works both ways yet. d

It only goes one way, `regex === string`, just like it only goes one way for matching instances of a class,  `String === string`

Here's a cool one for building a command line program.

```ruby
print "Continue? (y/n) "
answer = gets
case answer
when /^y/i
  puts "Great!"
when /^n/i
  puts "Goodbye!"
  exit
else
  puts "huh?" # lol
end
```

You can also use grep in that it also does a case equality match and returns to you an array of all the matched strings, you should give it an array.

```ruby
["USA", "UK", "France", "Uganda"].grep(/[a-z]/)
# ["France", "Uganda"]
```

Grep essentially does a select operation based on the case equality matcher.

You can also give it a code block to do a select and then map type thing.

```ruby
["USA", "UK", "France", "Uganda"].grep(/[a-z]/) {|word| word.upcase}
# ["FRANCE", "UGANDA"]
```
