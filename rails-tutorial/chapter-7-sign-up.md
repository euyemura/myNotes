# Chapter 7: Sign Up

Now that we have the ability to store a User with all its info, name, email, and password, it's time that we give a view, a front end, that will allow a person to send information to our database.

So, we need a page for creating a User, and then a page for showing a User as well.

Right now, our validations will make do as a way to ensure we have valid email addresses, but we will soon add an account activation step to be doubly sure, as it would force them to log onto a valid email account in order to activate it.

Just cause an email format is valid, does not mean that it is a real email nahmsaying

## Showing Users

Our user profile page should have a picture, a list of their microposts, as well as all of their user information.

We will also have followers and following, which is great.

### Debug and Rails environments

There's actually a really solid rails way to add debugging information to your views, we're going to add this to the application layout at the bottom of the 'container' div.

`<%= debug(params) if Rails.env.development? %>`

There are three default types of environments in Rails, we have development, production, and a test environment.

By default, the Rails console will open up in a development environment.

```ruby
Rails.env
#  "development"
Rails.env.development?
# true
Rails.env.test?
# false
Rails.env.production?
# false
```

In this above example, we are querying the `Rails` object, which has a `env` attribute, which has different methods associated with it.

If you want to run it in a different environment, then you can do this.

`rails console test`

How about opening the server in a different environment though?

`rails server --environment production`

We can style the debug output just like we style anything else, but we are going to take advantage of SCSS and use mixins, which can shorten our CSS code.

```css
@mixin box_sizing {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
/*  Right above we are defining the mixin, and this whole border box thing may be used multiple times in which case it's worth defining the mixin. */

/* miscellaneous */

.debug_dump {
  clear: both;
  float: left;
  width: 100%;
  margin-top: 45px;
  background-color: yellow;
  @include box_sizing
}
```
```ruby
puts u.attributes.to_yaml

# id: 1
# name: Akichann
# email: euyemura@learn.edu
# created_at: !ruby/object:ActiveSupport::TimeWithZone
#   utc: &1 2019-04-26 00:53:35.018360000 Z
#   zone: &2 !ruby/object:ActiveSupport::TimeZone
#     name: Etc/UTC
#   time: *1
# updated_at: !ruby/object:ActiveSupport::TimeWithZone
#   utc: &3 2019-04-26 01:01:46.319691000 Z
#   zone: *2
#   time: *3
# password_digest: "$2a$10$/jHT3oZ/XukUY7Q0qBfm.eCVzYuvk1NK4CKrzUBV2baQIy0yCtMaq"
#  => nil

```
`puts u.attributes.to_yaml == y u.attributes`

### A Users resource

`User.count` is 1.

A short definition of REST architecture in terms of Rails applications, representing data as resources that can be created, shown, updated, or destroyed.  These four actions correspond to the four fundamental operations: post, get, patch, delete as defined by the HTTP standard.

This means that if I want to view the `User` with an id of 1, then I should issue a get request to URL/users/1. A get request is automatically handled by Rails as a Show action.

So, how do we get these resources though???  Just need to add a single line to our routes file.

`resources :users`

Adding this one line gives us all of the actions needed for a RESTFul Users application.

So it gives you all of the urls in order to be restful, but doing this still means that you need to make your own controller, not too bad.

Now, if we want to go to our users page, well, try going to the users page.

But I believe that we will need to have a corresponding action in the controller as well, if I'm not mistaken.  

Yay thank god I was right, here it is in all it's glory.

```ruby
def show
  @user = User.find(params[:id])
end
```

`params[:id]` actually returns a string, as I believe the data type for all parameters would be a string, but Rails knows to convert this to an integer.

### Debugger

Previously on Dragon Ball Z, we used eRB to add a debug popup into our application layout file, which told us about the params and whatnot, but a more powerful interactive way to do this is by using `byebug`.  

```ruby
def show
  @user = User.find(params[:id])
  debugger
  # what's difference between that and byebug?
end
```

Into the byebug prompt, ` puts @user.attributes.to_yaml`
Quite similar to the debug prompt that we installed.

Put the debugger in the `users#new`. The user @user is definitely nil, as we haven't passed it as an instance variable, and I don't think it'll ever be anything other than nil.

To continue on from a byebug prompt, just hit control + d

### A Gravatar image and a sidebar

Gravatar is a 'globally recognized avatar', they're great because it means you don't have to deal with uploading images and whatnot on your site.

You just need to send out a call to a site utilizing the user's email address.

We will be doing this by creating a `gravatar_for` helper method. This is going to be great.

This is what the view has become.

```
<% provide(:title, @user.name) %>

<h1>
  <%= gravatar_for @user %>
  <%= @user.name %>
</h1>
```

Per the Gravatar documentation, the URL must be based on a MD5 Hash, ah yes, the good ol MD5 hash.  Here's how you implement it in Ruby, using the Digest library.

```ruby
email = 'euyemura@learn.com'
Digest::MD5::hexdigest(email.downcase)
```

So, any helper that you put in any helper file can be used in any view, but just for organizations sake, this goes for the User table, so lets just put it in the user helper section.

```ruby
module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
```

This is honestly pretty awesome, the method returns the last statement, which is a call to another rails method, inputting the url and then all of the respective html attributes.

And actually everything just works now! What the heck.

His email was fake so it resulted in the default icon, but if we wanted to change this.  You can open up a rails console session and do some changing.

```ruby
user = User.first
user.update_attributes(name: "Example User",
                       email: "whatever@test.com"
                       password: 'foobar'
                       password_confirmation: 'foobar')
```

Look, when you are updating things the long way, you must enter in all fields once again, or else the change won't take.

```
<% provide(:title, @user.name) %>

<div class="row">
  <aside class= "col-md-4">
    <section class="user_info">
      <h1>
        <%= gravatar_for @user %>
        <%= @user.name %>
      </h1>
    </section>
  </aside>
</div>
```

Well, I just learned about another HTML semantic tag, the `aside` which is something that complements a page but can standalone in a way.

they also gave us some css we can implement into the sidebar via the custom.scss page.

We want to allow for the gravatar helper to accept an options hash that could contain a size key value pair.

```ruby
module UsersHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end

module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end

# and then we call it like this inside of the show.html.erb  

# <%= gravatar_for(@user, size: 80) %>
```

## Signup Form

So we have a working show page, but now we need to do another REST action, that of create, new, signup, etc.  

### Using `form_for`

Basically, we need a way to allow a user to input the correct information, and send that to our database.  This is where the `form_for` rails helper method comes into place, it takes an active record object and builds a form using the objects attributes!  And by an active record object, we're talking about an instance of a data table, or all the columns in the table rather.

So, we need to send this object to the view, and where do we do that?? The controller.

```ruby
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    # because this creates a User object that has all of the attributes that we need, but every single attribute has a value of nil.
  end
end
```


app/views/users/new.html.erb
```
<% provide(:title, 'Sign up') %>
<h1>Sign up</h1>

<div class="row">
 <div class="col-md-6 col-md-offset-3">
   <%= form_for(@user) do |f| %>
     <%= f.label :name %>
     <%= f.text_field :name %>

     <%= f.label :email %>
     <%= f.email_field :email %>

     <%= f.label :password %>
     <%= f.password_field :password %>

     <%= f.label :password_confirmation, "Confirmation" %>
     <%= f.password_field :password_confirmation %>

     <%= f.submit "Create my account", class: "btn btn-primary" %>
   <% end %>
 </div>
</div>
```

So, the `form_for` helper, you pass it an object, which is the new instance of whatever data model you are instantiating.  You then give it a block variable, which represents an object that has many other helper methods.  These helper methods expect an argument, that argument is a symbol, which represents a key in a hash that represents the different columns inside of whatever data model that you are instantiating, get it?

### Signup form HTML

When the block variable `f` comes along with an html element, a text field, or a radio button(which will set an attribute), or password field, `f` returns the code for that element which is then designed to set an attribute for the `@user` object

```ruby
<%= f.label :name %>
<%= f.text_field :name %>
```
I think something to note here is that all of the inputs that are created from the `form_for` helper have different types, `text`, `email`, `password`, this does have some impact.  A type of `password` will obscure the characters that are typed in which is for security purposes, a type of `email` will bring up a keyboard on mobile devices that is optimized for entering in an email, you know what I'm talking about.

Each input also has a `name` attribute that has a value of something like `name="user[name]"`, this allows rails to create an initialization hash in order to construct hte user object that is about to be created, it does this using the params variable

The `form` element itself has an action of `"/users"` and a method of `post`, which means that it can send an HTTP `post` request to the `/users` URL

```html
<form action=" /users" class="new_user" id="new_user" method="post">
```

The action corresponds to the url the website is sending information to, and the post is the correct http verb for creating a new object, so the form creates an initialization hash, sends it to /users with a post method.

## Unsuccessful Signups

So, now we're going to look at the errors that we get when we try to submit an invalid user.  However, immediately when pressing submit on an empty user, we don't get our validation errors, instead, we get the Rails error that there is no create action.  This means that we have to create the `create` action and send it the information that we have gathered from the form.

### A Working Form  

We will be using the `render` method again, which we first saw in the context of partials.  

You can also use render in controller actions.

The next strategy we are using is a conditional structure inside of our controller, depending on the return of the `@user.save` method (which can be true or false) we are going to do something.

Here's a portion of what it will look like.

```ruby
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    debugger
    @user = User.new(params[:user])    # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end
end
```

Alright so this is cool, I have a controller with a `create` action, all i put inside of it was a debugger, I then looked at what were in the params, under params[:user], i got the entire hash that was needed in order to make a new user, which is why the code above should work given valid information `User.new(params[:user])`

Ok, but the above example wasn't working, apparently there was a forbiddenattributeserror, this is where those darn strong params come in, you have to let Rails know which values you want coming in, which attributes you are allowing to save to the database.

This is dangerous, we don't want to allow a user to enter in whatever attributes that they please.  For example, when we are making someone an admin, they pass into the hash a `admin = '1'` value.  Of course, you may be wondering, well, in our example of the sign up page, there is only the inputs that we have created, so why would this be a problem?  That's true, according to the view we created, it would be safe, but, using a command-line http client like `curl` one could pass into the params hash whatever they wanted!

Now, in Rails 4.0 and later, we have strong parameters, which specifiy which parameters are required and which are permitted.

```ruby
params.require(:user).permit(:name, :email, :password, :password_confirmation)
```

So this is what we need.

It's also conventional to introduce an auxiliary method called `user_params`, this method returns an appropriate initialization hash, and uses it in place of `params[:user]`

```ruby
@user = User.new(user_params)
```
Since it's only being used in the Users controller, we can make it a private method.  

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
```

### Signup error messages

I can't quite remember why in my portfolio it automatically provided error messages, however, we will be implementing a partial in order to display the `user.errors.full_messages`, and then we will be adding a class of `form-control` to it, this has special meaning to Bootstrap.

```
<% provide(:title, 'Sign up') %>
<h1>Sign up</h1>

<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <%= form_for(@user) do |f| %>
      <%= render 'shared/error_messages' %>

      <%= f.label :name %>
      <%= f.text_field :name, class: 'form-control' %>

      <%= f.label :email %>
      <%= f.email_field :email, class: 'form-control' %>

      <%= f.label :password %>
      <%= f.password_field :password, class: 'form-control' %>

      <%= f.label :password_confirmation, "Confirmation" %>
      <%= f.password_field :password_confirmation, class: 'form-control' %>

      <%= f.submit "Create my account", class: "btn btn-primary" %>
    <% end %>
  </div>
</div>
```

We have put this partial in a `shared` directory, which is normal when you are using a partial across views.

`mkdir app/views/shared`

Here's the code for the partial

`app/views/shared/_error_messages.html.erb`

```html
<% if @user.errors.any? %>
  <div id="error_explanation">
    <div class="alert alert-danger">
      The form contains <%= pluralize(@user.errors.count, "error") %>.
    </div>
    <ul>
    <% @user.errors.full_messages.each do |msg| %>
      <li><%= msg %></li>
    <% end %>
    </ul>
  </div>
<% end %>
```

There's some Rails things here, but mostly we see a lot of different Ruby methods, for example, we have `empty?` and `any?` which test if there is any content, although I always thought that any?

There's also a really cool `pluralize` helper, this is available in the console but I don't believe that this is core ruby.

```ruby
# you access it with the helper object
helper.pluralize(1, "error")
helper.pluralize(4, "error")
helper.pluralize(1, "goose")
helper.pluralize(9, "goose")
# so it doesn't know the plural of goose but it does know the plural of octopus which is a bit odd.
```

Because we have added id's and class names to these elements, we can style them in our custom.css file.


```css

/* forms */
.
.
.
#error_explanation {
  color: red;
  ul {
    color: red;
    margin: 0 0 30px 0;
  }
}

.field_with_errors {
  @extend .has-error;
  .form-control {
    color: $state-danger-text;
  }
}
```

I assume that the URL for the unsubmitted form `/signup` and the submitted sign up form `/users` is different because Rails expects to redirect you to the actual user, however, because it wasn't a valid user, it kind of stalled out on just `/users` instead of `/users/2` or whatever.

### A test for invalid submission

Instead of the old days when we had to test applications by hand by entering in every combination of invalid data and then valid data, and then repeating those changes whenever the site changed, we can now just create automated testing, we will do this now.

`rails generate integration_test users_signup`

This is dope, first we do a get request on the signup_path, because of course, we need to go to the signup page in order to test it.

`get signup_path`

```ruby
assert_no_difference 'User.count' do
  post users_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"
    }}
end
# you may be wondering why we are adding a params hash, params[:user], well, it's because that's what the controller is expecting by the User.new part of the create action.
```

This is pretty much the same thing as writing something like this.

Essentially what we are doing is giving User.count to the assert_no_difference method, which will check it before and after the code block has run, and from then on it will make sure that there is indeed no difference, the assertion that we made.

```ruby
before_count = User.count
post user_path # and all the other shit, posting the params[:user] and whatnot.
after_count = User.count
assert_equal before_count, after_count
```

I think the thing that is interesting here, is that the get and post actions are not really related, it makes it clearer when reading it, first we are going to the signup path, and then we are hitting the post action, but really we could just hit the post action without going to get, because as far as rails is concerned, it doesn't matter where we are sending that post action from.

```ruby
test "invalid signup information" do
  get signup_path
  assert_no_difference 'User.count' do
    post users_path, params: { user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"} }
  end
  assert_template 'users/new'
      # so i guess the thing i'm confused about is how important the ordering here is, like, is it really posting somethiing, and then aftewards being like, i'm also asserting that now we are going back to the users/new page.  what if we changed it, would the test fail, lets see!
  assert_select "div#error_explanation div.alert", "The form contains 4 errors."
  assert_select 'div.field_with_errors'
  # as you can see we have some assertions based on the html that Rails created with our error partial.  I kind of wanted to go more in depth on this side of things,
end
```


## Successful Signups

```ruby
def create
  @user = User.new(user_params)    # Not the final implementation!
  if @user.save
    # redirect_to user_path @user
    redirect_to @user
  else
    render 'new'
  end
end
```

Thats the fully implemented create action
