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

### Exercises

Write out steps for visiting the url "/users/1/edit"

So the guest enters in this url, this url is passed to the router who understands which controller this should go to and which action it needs to get, i think its the update action, because the id is included in the parameters, the controller takes it and goes to the model and says, give me back this users' info, that users info is given from the model to the controller, and passed as an instance variable to the view, who passes it to the form as a local variable, and then the html is output to the user.

### What are the weaknesses of this scaffold?!?!

1. NO data validations, we can enter without a name or an email.

2. no authentication, there's no admin roles or user roles, a user can do just as much as an admin inside of this app.

3. NO tests that test for data validation, authentication, or any other custom requirements.

4. Terrible styling
