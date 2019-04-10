# Chapter 6: Modelling Users

Why build our own instead of just using something like devise?

If you are ever creating an app with authorization and authentication, you will most likely be using a third party option. However, you'll still have to customize these options.  If you write your own, then you'll understand much more about that process, as opposed to changing code in a black box.  

## User Model

First we need to make a data structure that can capture and store user information.  Then we can make a signup page that actually accepts this information and gives it to the database.

So, we'll be using a data model.  The defualt library for interacting with the database is Active Record.  This allows you to write Ruby code instead of SQL in order to make data queries and to create data definitions.  

`git checkout -b modeling-users`

### Database migrations

Each User will have a name and email, which will act as their unique username.

We modelled this earlier by creating a User class like so...

```ruby
class User
  attr_accessor :name, :email
end
```
`rails g model User name:string email:string`

This is different than when we made a controller because a controller would be plural, but a model is singular.

We have now created a migration file, and I think we have to  `rails db:migrate` now

```ruby
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
      # creates created_at and updated_at columns
      # class of these columns is Datetime
    end
  end
end
```

After you migrate you may want to go back to destroy the Users table, just hit `rails db:rollback`

### The model file

```ruby
class User < ApplicationRecord
end
```

The model file is pretty empty, but that's just because it inherits from ApplicationRecord, which inherits from ActiveRecord::Base, which gives us a ton of functionality from the getgo.

### Creating user objects

If you want to experiment with our data models, just use a sandbox.

`rails console --sandbox`

model objects take hashes as arguments...

`user = User.new(name: "Eric Uyemura", email: "e@test.com")`
`user = User.new(:name => "Eric Uyemura", :email => "e@test.com")`
