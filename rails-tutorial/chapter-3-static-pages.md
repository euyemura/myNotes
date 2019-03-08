# The beginning of the sample app

This will start with just creating a static page!

This will also begin the introduction to testing.

# Sample App Setup

1. Set up the gemfile!
2. bundle install --without production
3. Add it under git!
4. Update readme!
5. Give it a hello world message, we do this because generally heroku does not like the default rails welcome page.
6. Switch to a new branch to get ready for the static pages.

## Generated Static Pages

`rails generate controller StaticPages home help`

See here, the 'arguments' in this command will be the methods that are created in this controller, or we can call them the actions.

Then we push this, and remember, when we are pushing a branch.

`git push origin static-pages`

`StaticPages` turns into `static_pages_controller.rb`
`static_pages` has the exact same effect.

He prefers the camel case because Ruby uses CamelCase for class names.

What happens if you mess up when you are generating something?

`rails generate controller StaticPages home help`
`rails destroy controller StaticPages home help`

`rails generate model User name:string email:string`
`rails destroy model User`

There you go.

To go back one migration , `rails db:rollback`

To go back to the very beginning, `rails db:migrate VERSION=0`

### HTTP Protocol

HTTP defines basic operations get, post, patch, delete. These operations refer to the interactions between a client and a server.  An emphasis on HTTP verbs is typical of web frameworks influenced by REST architecture.

Get is for reading data.  post is for submitting a form, and for rails it can be used to update things.  Patch and delete are for updating and destroying things on the remote server. These are less common because browsers can't send them natively, but Rails has ways around that.

As you may have noticed, which I didn't notice, the static pages controller does not use standard rest actions,  we're not doing a new resource, or a show resource, or deleting or updating a resource, instead we just need to get a static page.

## Getting started on testing

Three benefits of automated tests!

1. Tests protect against regressions, where a functioning feature stops working for some reason. They'll tell you where the test is failing, so it helps.
2. Tests allow code to be refactored. with greater confidence. Changing its form but not its function.
3. Tests act as a client for the application code, thereby helping determine its design and its interface with other parts of the system.

Write controller and model tests first usually, and maybe write integration tests second.  

## Our First Test

We already have a directory called test.

RED > GREEN > REFACTOR

```ruby
class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end
  test "should get about" do
    get static_pages_about_url
    assert_response :success
  end

end
```

This will fail.

But now we can add a get request to our routes page, which will create the helper that is `static_pages_about_url`, this prefix is actually a helper I had no idea.

We followed the errors, so first change routes, then change controller, then add html view file, and then we're green, then refactor, but there's really nothing to refactor right now.


### Slightly Dynamic Pages

We want the titles to change for each page.  This is an interesting one, as I think it should have to do with changing the layout of the application.

`mv app/views/layouts/application.html.erb layout_file`

This will temporarily disable the layout file by changing its name.

And here's the test for the titles.

`assert_select "title", "Home | Ruby on Rails Tutorial Sample App"`

```ruby
test "should get about" do
  get static_pages_about_url
  assert_response :success
  assert_select "title", "About | Ruby on Rails Tutorial Sample App"
end
```

`rails test` WE have to make sure they fail first, red, then green, then refactor

Next we implement a regular layout for each of the view files, which the layout file originally took care of, we put in the titles, and lets see if they pass.

WE have a lot of repetitive code in our test however, let's fix that.

```ruby
class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
```

Ok, so all of our tests pass.  We finished the green section, and now it's time to do the refactoring.  As you know, instead of capitalizing on the application layout, we provided the html skeleton for each static page.  This is not really necessary.  

So, we'll be using a Rails function called provide to take care of this.

```
<% provide(:title, "Home") %>
<title><%= yield(:title) %>
```

Now it's time to get back the application layout file.

`mv layout_file app/views/layouts/application.html.erb`

And then we clean up the views that have all the html structure, they only need the body and the provide!

This is the beautiful thing about testing, once we refactor, we have a rather reliable way to verify that everything is working as intended.

## Setting the Root route

Pretty easy stuff.

Next we modified our testing to make it faster and to run automatically when it detects changes.

## Unix Processes

To see all the processes on your system, you can use the ps command with the aux options:

`$ ps aux`
`ps aux | grep spring`

`spring stop`
`pkill -15 -f spring`
