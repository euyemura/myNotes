# Learn Ruby

First we need to make a new branch to test out any new features we make.

1. `git checkout -b rails-flavored-ruby`

Ok, for the first example let's look at a line in the application layout file.

`<%= stylesheet_link_tag 'application', media: 'all',
                                       'data-turbolinks-track': 'reload' %>`

So apparently there are four potentially confusing ruby ideas going on here.

1. built-in Rails methods
2. method invocation with missing parentheses.
3. Symbols.
4. Hashes.

## Custom Helpers

We're going to create our own custom helper.  

`<%= yield(:title) %> | Ruby on Rails Tutorial Sample App`

Basically, every static page needs to have provided a title for this line to work in the application layout file. like so .

`<% provide(:title, "Home") %>`

So, it's probably a better idea to create this using a helper, because a helper can have the logic in order to allow for a base title when no title is provided.

Aite, so where do we put this helper?

WELL. In the 'helpers' directory, we have an application helper and a static pages helper.  So, I believe that because we are going to be using this helper inside of the 'application' layout, we should put it in the application helper.  

Here is the helper in all its glory

```ruby
def full_title(page_title = '')
  base_title = 'Ruby on Rails Tutorial Sample App'
  if page_title.empty?
    base_title
  else
    "#{page_title} | #{base_title}"
  end
end
```

And here is how we call it in the application layout file.

`<title><%= full_title(yield(:title)) %></title>`

## Strings and methods

So, you know how for special characters you sometimes have to escape them in order to get them to print correctly, with single quotes, you don't need to do that, it prints everything literally.  YOu will have to escape characters in the double quotes though, since they give you extra functionality.

## Back to the helper
