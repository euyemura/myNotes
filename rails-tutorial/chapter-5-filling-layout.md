# Filling in the layout

We'll be putting some css into our application layout as well as adding links to each page, and all the while learning about...
- partials
- rails routes
- asset pipeline
- Sass

We'll also take a first important step towards letting users sign up for our site .

We will also write our first integration test.

## Adding some structure

`git checkout -b filling-in-layout`

### Site navigation

```ruby
<header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <%= link_to "sample app", '#', id: "logo" %>
    <nav>
      <ul class="nav navbar-nav navbar-right">
        <li><%= link_to "Home",   '#' %></li>
        <li><%= link_to "Help",   '#' %></li>
        <li><%= link_to "Log in", '#' %></li>
      </ul>
    </nav>
  </div>
</header>
<div class="container">
  <%= yield %>
</div>
```

So this is what we are putting inside of the application layout file, as you can see we are making use of the `link_to` rails method, you give it the name of the link, and then you give it the path.

`<!--[if lt IE 9]>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/r29/html5.min.js">
  </script>
<![endif]-->`

This is actually pretty interesting, it's a conditional statement that can be read by browsers that checks whether we are working with internet explorer, if so, we're not going to use HTML5! I think HTML5 is the thing that brought semantic tags, in which case tags like <header> will not be understandable to internet explorer.

HTML5 adds semantic markup, `header` `nav` and `section` for example. and `footer` and `article`.

```ruby
<%= link_to "sample app", '#', id: "logo" %>
<nav>
  <ul class="nav navbar-nav navbar-right">
    <li><%= link_to "Home",   '#' %></li>
    <li><%= link_to "Help",   '#' %></li>
    <li><%= link_to "Log in", '#' %></li>
  </ul>
</nav>
```

Check out the first one, there are a few different arguments, strings and then a last optional options hash.  The options hash of course i assume can be in any order, and also, remember, no curly brackets are necessary.  

Many of the rails helpers do have options hashes available as arguments which is pretty awesome.

Next we add some markup for the home page.

```HTML5
<div class="center jumbotron">
  <h1>Welcome to the Sample App</h1>

  <h2>
    This is the home page for the
    <a href="https://www.railstutorial.org/">Ruby on Rails Tutorial</a>
    sample application.
  </h2>

  <%= link_to "Sign up now!", '#', class: "btn btn-lg btn-primary" %>
</div>

<%= link_to image_tag("rails.png", alt: "Rails logo"),
            'http://rubyonrails.org/' %>
```

Rather we are replacing it.

### Bootstrap and custom css

Bootstrap by default uses the Less CSS language, while the Rails asset pipeline uses Sass, the gem, `bootstrap-sass` converts Less to Sass and makes bootstrap available for Rails use.

In the gemfile,

`gem 'bootstrap-sass', '3.3.7'`
`bundle install`

Now, as you know, there is a css file for each controller, but getting them to be included and in the right order can be confusing, so we'll just create a separate css file to bypass this.  This means creating a new css file.

`touch app/assets/stylesheets/custom.scss`

Inside of this file we need to include bootstrap and sprockets.

```SASS
  @import "bootstrap-sprockets";
@import "bootstrap";
```

These two commands add the entirety of bootstrap to our app.

Next he gave us some CSS to put in that custom.scss file.

Look I can comment out erb like this...

`<%#= image_tag("kitten.jpg", alt: "Kitten photo" ) %>
`

### Partials

We're going to be using two partials, one for the IE conditional HTML shims, and the other for the header.

```
<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
<%= render 'layouts/shim' %>
</head>
<body>
<%= render 'layouts/header' %>
<div class="container">
  <%= yield %>
</div>
</body>
```

As you can see, both of these partials are going to live in the layouts folder, which is in views. Why layouts?  Because they are being called in the application LAYOUT.

`<%= render 'layouts/shim' %>` is going to look for this line.
`app/views/layouts/_shim.html.erb`
An underscore follwed by the name of the partial, and this of course is also erb, so that's why it needs that file extension.

And no file extension is needed when you're actually calling it.  

Now our application layout file looks much cleaner.

Now we'll be adding a footer partial.

Exercise!  Replace the head along with the doctype of the application layout file to a partial. mkae sure your tests fail before they pass again.

All of our tests pass, so lets push it.

## Sass and the asset pipeline

The asset pipeline makes simple managing the static assets such as CSS, JavaScript, and images.

### There are three main parts to understand about the asset pipeline.

- Asset directories
- Manifest files
- Preprocessor engines

### Asset directories

The rails asset pipeline uses three standard directories for static assets, each with its own purpose:

- `app/assets` : assets specific to the present application.
- `lib/assets`: assets for libraries written by your dev team.
- `vendor/assets` : Assets from third-party vendors.

I don't get it.

Each of these has subdirectories for each asset class: images, JavaScript, and CSS

So, why did we put the `custom.scss` file inside of the app assets, instead of the other two, well because these style rules are specific to the sample application.

#### Manifest files

The manifest files tell Rails via the sprockets gem how to combine them to form single files, this only applies to CSS and JavaScript files, but not for images.

#### Prprocessor engines

So basically what happens is, you assemble your assets, and they must first be preprocessed using the preprocessing engines, then the manifest files to combine them for delivery to the browser.  We know which preprocess we need to use based on the file extensions, scss, coffee, and .erb.  

Coffeescript gets converted to javascript.

you can have multiple preprocessor extensions.

`foobar.js.erb.coffee` coffee first, then erb is processed.

#### Efficiency in production

Generally, when we are organizing CSS and Javascript files, we put them in different files to be managable from a developer's perspective, however, it makes the site slower.  The asset pipeline combines everything into files like, application.css and application.js, and then minifies them for you!

### Syntactically awesome stylesheets

SCSS is straight awesome, nesting, variables, mixins, makes the code so much cleaner, and the rails asset pipeline processes it automatically for you.

#### Nesting

#### variables

`$light-gray: #777;` now we can use this anywhere, however, the bootstrap sass gem already has variables names for a bunch of colors, we shall be using theirs. `$gray-light`

### Layout Links

It's time we fill in all of the links that are currently inactive.

We could do this `"/static_pages/about"` which would be fine, butit's not the rails way.

`<%= link_to "About", about_path %>` would be much prettier.

`root_path` -> '/'
`root_url` -> 'http:/www.example.com/'
The url gives the full, or maybe the absolute path?

Generally you use the path, however, when doing redirects HTTP protocol says you should be using the full url.

```ruby
get '/help' => "static_pages#help"

get '/about', to: "static_pages#about"

get '/contact', :to => "static_pages#contact"
# i wonder if this last variation will work, the full hash syntax.
```

All the tests fail now, because the helper paths are no longer accurate, once we change them in the routes all the prefixes are changed accordingly.

Now `static_pages_about_url` is just `static_path` change it to path because thats more common, less space.

Also, all three of my get variations do work!  Thank god ruby works .

You can change the named routes,

`get '/help' => 'static_pages#help', as: 'helf'`

This means that the prefix has now changed, which means your tests will now fail, this is just a exercise, change it back now.

### Using named routes

Lets just fill in all of the links now

### Layout link tests

We should test all the links we just set up, we could do this by hand, but this is a good time to use an integration test, which is an end to end test of our application's behavior.

We do this by generating a template test, we'll call it, `site_layout`

`rails generate integration_test site_layout`

Testing the layout links involves checking the HTML structure of our site.

1. Get the root path (Home page)
2. Verify that the right page template is rendered
3. Check for the correct links to the Home, Help, About, and Contact pages.

```ruby
test "layout links" do
  get root_path
  assert_template 'static_pages/home'
  assert_select "a[href=?]", root_path, count: 2
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", about_path
  assert_select "a[href=?]", contact_path
end
```

Here is step 1. get the root path.
After reading the path this is prettyt sick.  So basically, it says, go to the home page, then, does that page match the home.html.erb page, then, it says that there should be multiple links, and they should be the paths that we say, and you can even tell it how many of each link there are.

`assert_select "a[href=?]", about_path`
turns into, `href="/about"`

So let's test the code

`rails test:integration`
`rails test`

We can actually use our `full_title` helper in our tests by including the application helper into the test_helper file.

`include ApplicationHelper`

```ruby
test "layout links" do
  get root_path
  assert_template 'static_pages/home'
  assert_select "a[href=?]", root_path, count: 2
  assert_select "a[href=?]", help_path
  assert_select "a[href=?]", about_path
  assert_select "a[href=?]", contact_path
  get contact_path
  assert_select "title", full_title("Contact")
  # these are the newest tests, to get the contact path and assert that there is a title with the full_title("Contact") title.
end
```

Then create a test for the full title helper by making a new file

`test/helpers/application_helper_test.rb`

```ruby
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         FILL_IN
    assert_equal full_title("Help"), FILL_IN
  end
end
```

```ruby
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  test "full title helper" do
    assert_equal full_title,         "#{@base_title}"
    assert_equal full_title("Help"), "Help | #{@base_title}"
  end
end
```

In the end thats what I had, lets see if tests pass or not.

All green

## User signup: A first step

We are going to make a controller for users, one of the routes will be a sign up page.

### Users controller

`rails generate controller Users new`
remember, a controller is plural, a model is singular.

We enter in the `new` action because that's the actual page we want, a sign up page, this is what it should be according to REST architecture.

Test it as the controller generation creates new test.

Now we no longer want the route name to be  `users_new_url`, it should be `signup_path`

We first change the tests to reflect this and make sure they fail.

Here's how I got them to pass.

`get 'users/new', as: "signup"`

This doesn't change the url though, which is what I think they wanted, either way here's another way to do it.
`get 'signup', to: "users#new"`

Now let's fill in the path inside of the home.html page.

Then we fill in the html for the view which we can test.
`<% provide(:title, 'Sign up') %>
<h1>Sign up</h1>
<p>This will be a signup page for new users.</p>`

Here's a cool way to do it.

`assert_select "title", full_title('Sign up')`

A lot of times ppl put partials inside of the shared directory, which you must create, you can do this for things that span multiple views or controllers, but for this purpose he put them in the layouts directory. 
