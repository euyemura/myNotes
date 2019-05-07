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

Basically, we need a way to allow a user to input the correct information, and send that to our database.  This where the `form_for` rails helper method comes into place, it takes an active record object and builds a form using the objects attributes!  And by an active record object, we're talking about an instance of a data table, or all the columns in the table rather.

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
