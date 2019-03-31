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
