# The RSpec Hooks

Sometimes when you get into more complex testing, before each example runs, or after each example runs, you want to do something to an objects state, mayble clear it of an attribute or something or other. These are great times to use these lifecycle hooks inbetween your example groups.

So we have different symbols to represent different hooks inside the before or after blocks.

`:example` : happens before or after EVERY SINGLE EXAMPLE block
`:context` : happens before or after the entire describe block that it is within, and remember, you can have nested describes or contexts.
