
# We're making a toy app!

This is going to be a scaffold driven app to get you in the Rails waters, and then we'll dive into the magic.

## Setup

1. Create a new rails app using a specific version number.

`rails _5.1.6_ new toy_app`

2. Next we're going to change our gemfile.

3. We must bundle install, but because we will be using pg only in production, i.e. when it is deployed on heroku, first we will bundle install without any of our production gems. Since heroku already has postgres.

`bundle install --without production`

4. Add the repository to git version control.

`git init` not necessarily necessary.

`git add -A` not sure what this is

`git commit - m "WHATEVER"`

And then get the links from github after you've made a new repository.

5. Next we launch the app on heroku.

`heroku create`

`git push heroku master`

## Models

Typically the first thing that you are going to do is to create a data model when you are making a web application. It is a representation of the structured needed by our application.

This is a twitter-style microblog with users and microposts.

<hr>

### Users

User is the name of the table, and the data attributes are columns in that table.

- id:integer
- name:string
- email:string

### Microposts

- id:integer
- content:text (not string, text is longer)
- user_id:integer

We have to create a relationship for these posts.  Each post belongs to a user, and users have many posts. Get it?

<hr>

So, when we make a Users table, what we are doing is creating a <i>Users resource</i>  remember, HTTP is a way to ask for and retrieve resources.

1. First we need to generate all of the things we need for a User, we want CRUD functionality. So, we don't go with a resource, or a model, or a controller, but a SCAFFOLD, the most bloated choice.

`rails g scaffold User name:string email:string`

2. Next we migrate.

3. Now we can visit the site with some stuff like, "/users"

Remember that each url corresponds to an action, and parameters in the url give information to that action, like a 1 can be an :id parameter that tells the controller which User it needs to retrieve so it can show it, edit it, or delete it.

4. Try to associate the root route with the /users route, so /users is the new home.

`root 'users#index'`

A <i>controller</i> contains a collection of related <i>actions</i> for a certain resource. You may or may not have a model, a model is only needed when you need information that persists.

All of the url actions that we have, the controller actions that is, represents the implementation of the REST architecture, which is a way of sending messages to a server with your url.  Representational state transfer.  

## REST

It's an architectural style for developing distrubted, networked systems and software applications such as the WWW and web applications.

It means that application components are modeled after resources that can be created, read, updated, and destroyed.  These operations correspond to the CRUD operations on relational databases, as well as to the four fundamental HTTP request methods, post, get , patch, delete.

This means, that you must simply structure your applications using resources or application components that get created,read, updated, and deleted.  

### Exercises

Write out steps for visiting the url "/users/1/edit"

So the guest enters in this url, this url is passed to the router who understands which controller this should go to and which action it needs to get, i think its the update action, because the id is included in the parameters, the controller takes it and goes to the model and says, give me back this users' info, that users info is given from the model to the controller, and passed as an instance variable to the view, who passes it to the form as a local variable, and then the html is output to the user.

### What are the weaknesses of this scaffold?!?!

1. NO data validations, we can enter without a name or an email.

2. no authentication, there's no admin roles or user roles, a user can do just as much as an admin inside of this app.

3. NO tests that test for data validation, authentication, or any other custom requirements.

4. Terrible styling

# THe Microposts Resource

First we need to scaffold.

1. `rails g scaffold Micropost content:text user_id:integer`

Interesting, you'd think a  micropost would just be a string due to the character limit, but this works, I'm sure you can always put a cap on the character limit after the fact, and this way, you can choose your own character limit.

2. Migrate

get patch and delete are same url, `/microposts/1` just with different methods attached to them.

So, the interesting thing here, and this confirmed what I thought earlier, that even though we have a column in our micropost table for  `user_id` we still don't have any connection to a user at the moment, it's not a foreign key.

Also, there is no character limit as well as no validations.

To do this, we need to go into the microposts model.

This is what the model should look like now.

3.  

```ruby
class Micropost < ApplicationRecord
  validates :content, length: { maximum: 140 }
end
```

And that works!

```ruby
class Micropost < ApplicationRecord
  validates :content, length: { maximum: 140 }
  belongs_to :user
end
```

```ruby
class User < ApplicationRecord
  has_many :microposts
end
```

And here we create the associations, I did that from memory baby. lets get it.

And remember, in the rails console, when you hit `User.last.microposts` even if its only one micropost, you will still have an array. so you can't do,  `User.last.microposts.user`, it would have to be, `User.last.microposts.first.user`

Now we update for validations...

```ruby
class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 140 }, presence: true
end
```

```ruby
class User < ApplicationRecord
  has_many :microposts
  validates :name, presence: true
  validates :email, presence: true
end
```

So now we can just push it up to github and heroku, and then make sure to migrate the database.

And everything works! Beautiful! 
