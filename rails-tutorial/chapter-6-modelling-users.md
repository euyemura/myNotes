# Chapter 6: Modelling Users

Why build our own instead of just using something like devise?

If you are ever creating an app with authorization and authentication, you will most likely be using a third party option. However, you'll still have to customize these options.  If you write your own, then you'll understand much more about that process, as opposed to changing code in a black box.  

## User Model

First we need to make a data structure that can capture and store user information.  Then we can make a signup page that actually accepts this information and gives it to the database.

So, we'll be using a data model.  The default library for interacting with the database is Active Record.  This allows you to write Ruby code instead of SQL in order to make data queries and to create data definitions.  

For this reason, along with using sqlite for development and postgresql for production via heroku, we don't even have to think about the nitty gritty of how rails stores data.

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

Also, the `class` method is usually always just `Class` because thats the object that instantiated it, to go up the inheritance chain, use `superclass`

For any `user` object or whatever object, you can always check whether it's a valid object by using the `user.valid?` method on it.


Whenever we create a `user` with the `.new` method, it is only saved in memory, in that current console session.  To save it to the database, you must use the `u.save` method. It'll either return true or false depending on a successful write to the database, we have no validations, so there should be no instance where it fails.

When we have a user made from `new`, it will at first not have an id nor the timestamps, as it is not in the database, once saved, it will.  However, if before the save you update the user, it'll automatically be saved to the database and those columns will of course be filled in.

`u2.name`
"Eric"
`u2.email`
"mouse@keyboard.com"
`u2.updated_at`
 Wed, 17 Apr 2019 19:41:22 UTC +00:00
`u2.created_at`
Wed, 17 Apr 2019 19:41:22 UTC +00:00

To save one step, we can use `User.create(name: "hwatever", email: "whateve@sfad.com")`

This will return the user object as opposed to a true or false, you can then save this to a variable.

`User.last.destroy` or `foo.destroy`

This will destroy it, return it, and will be saved in memory.

```ruby
2.6.1 :010 > u.created_at.class
 => ActiveSupport::TimeWithZone
 ```

So now that we've destroyed an object, how do we know if it's really gone?

Now it's time to learn active record commands .

### Finding user objects

`User.find(1)` This'll look for the User with the id of 1.

`User.find(3)`
ActiveRecord::RecordNotFound: Couldn't find User with ID=3

`User.find_by(email: "mhartl@example.com")`
=> #<User id: 1, name: "Michael Hartl", email: "mhartl@example.com",
created_at: "2016-05-23 19:05:58", updated_at: "2016-05-23 19:05:58">

Apparently find_by isn't the best for looking through large numbers of users, as lookup isn't great for some data structures.

 `User.all` returns all the users in an activerecord object, but it's stored inside the object as an array.  However, if you store it in a variable it behaves like an array.

#### Exercises

1. Find user by name, and confirm `find_by_name` an older rails convention.
2. Confirm that you can find the length of User.all by passing it the length method (Section 4.2.3). Ruby’s ability to manipulate objects based on how they act rather than on their formal class type is called duck typing, based on the aphorism that “If it looks like a duck, and it quacks like a duck, it’s probably a duck.”

### Updating User Objects

We can update things individually, just like any other object, it's interesting because even though this looks like a hash, you update it as if its an instance variable of a User object.

```ruby
user = User.create(name: "eric", email: 'hello')
user.email = 'ea.uyemura@gmail.com'
user.save

# if you dont save it then it won't take, as seen with the reload method.

user.email
# 't-racer@mail.com'
user.email = 'foo@bar.com'
user.reload.email
# 't-racer@mail.com'
```
ONce you do it successfully, you'll see the updated value is diferent now.

`update_attributes(name: 'something', email: 'something else')`

You can also pass just one value into here to save something in particular.
`update_attribute(:email, 'weird format')`

```ruby
user.created_at = 1.year.ago
# => Wed, 18 Apr 2018 01:02:42 UTC +00:00
user.save
user
#  => #<User id: 4, name: "T-racer", email: "new@test.com", created_at: "2018-04-18 01:02:42", updated_at: "2019-04-18 01:02:43">
```

## User validations

Here are some common validations.
- presence
- length
- format
- uniqueness
- confirmation (we'll get to this one later)

### A validity test

TDD is great for model validations!

Here's the concept.

1. Start with a valid model object (an actual user object of a real model)
2. Set one of it's attributes to something that should be invalid
3. Verify that it is indeed invalid.
4. However, as a precursor we should make sure that initial model object is valid, so that we know that our validations are failing for the ight reasons.  

Our generate command for the User model gave us the outline of a User test.

We already have the tools to be able to run this test.  We can use the `setup` method in order to create a regular `@user` instance variable that is subsequently available to all of the tests. We can then simply use the `valid?` method in order to test whether it's a valid object.

```ruby
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  # a test that I wrote
  test "should be valid for an empty user" do
    empty_user = User.new
    assert empty_user.valid?
    p empty_user
  end
end
```

Now, from the command line, `rails test:models` this again does not run the entire test suite, just like when we used `rails test:integration`

### Validating presence

Presence just tests whether a given attribute is not empty, and by empty I mean not nil, actually, an empty string would also fail a presence test as well.  

```ruby
test "should be invalid for an empty user" do
  empty_user = User.new
  assert_not empty_user.valid?
  # had to change this line because we don't want this to be valid, it fails like it should. Then we add validations and it should pass.
  p empty_user
end

test "name should be present" do
  @user.name =  "     "
  assert_not @user.valid?
end
```

This should not fail because we haven't set up any validations at this point.

`validates :name, presence: true`

This is just a method call, with two arguments, an options hash and a symbol of :name.

And now they pass successfully.

Say you've created a user with a blank name, you can get access to the error message by running a command like, `user.errors.full_messages`
` => ["Name can't be blank"]`

We get that error message, which shows us that Rails uses the `blank?` method in order to test for the presence of something.

Because we have an error, this user cannot be saved.  If the user is valid, and you run the error command, you will simply get back an empty array.

Now to write a test to make sure that an email has to have content, first we make the test fail.

```ruby
test "email should be present" do
  @user.email = "     "
  assert_not @user.valid?
  p "# here are email errors {@user.errors.full_messages}"
end
```

```ruby
# a sandbox session for exercises.
u = User.new
#  => #<User id: nil, name: nil, email: nil, created_at: nil, updated_at: nil>
u.valid?
# false
u.errors.full_messages
# => ["Name can't be blank", "Email can't be blank"]
u.errors.messages
#  => {:name=>["can't be blank"], :email=>["can't be blank"]}
u.errors.messages[:email]
#  => ["can't be blank"]
u.errors.messages[:email][0]
#  => "can't be blank"
```

### Length Validation

I think we'll have to test that having a length of over 50 characters for a name and over 250 characters for an email should be invalid, and once those fail, we'll check whether they pass after we implement the validations!.

Here's how we implemented those tests.

```ruby
test "names that are too long should be invalid" do
  @user.name = "h" * 51
  assert_not @user.valid?
  p "here are name length errors, #{@user.errors.full_messages}"
end

test "email should not be too long" do
  @user.email = "a" * 244 + "@example.com"
  assert_not @user.valid?
end
```

And here's that new user model.

```ruby
class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum:255}
  # same as validates :name, :presence => true
end
```

In sandbox I made a user with an email that is too long, this was not valid, and the error messages were .

```ruby
u.errors.messages
#{:email=>["is too long (maximum is 255 characters)"]}
```

### Format validations
Is this a time for regex??? I think it may be!

```ruby
%w[u can make an array like this remember that ok]
#=> ["u", "can", "make", "an", "array", "like", "this", "remember", "that", "ok"]
```

So we want to test not only that invalid email addresses are rejected, but that valid email addresses are accepted. So we will make a few valid email addresses and write a test that will make sure that they are all valid.

```ruby
test "email validation should accept valid addresses" do
  valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org  first.last@foo.jp alice+bob@baz.cn]
  valid_emails.each do |email|
    @user.email = email
    assert @user.valid?, "#{email.inspect} should be valid"
  end
end
# the reason we are giving a second message to the assertion is so that we can tell which if any email caused an error, as we are iterating over an array, any failure would just result in a pointer to the array itself, not which element in the array.
```

Next thing we need to do is test whether the format will reject any invalid emails, it shouldn't do this at this point as there is no format validation, which I'm sure rails has already.  

```ruby
test "email validation should reject invalid addresses" do
  invalid_emails = %w{user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com}
  invalid_emails.each do |invalid_email|
    @user.email = invalid_email
    assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
  end
end
```

Remember, at this point, the test will fail, as every email that isn't empty and is less than the maximum will be valid.

`validates :email, format: {with: /regex/}`

Here's my take on a regex.

```ruby
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
```

```ruby
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.{1}[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum:255}, format: {with: VALID_EMAIL_REGEX}
  # same as validates :name, :presence => true
end
```
WE had to make a change in the regex so that it only matches one dot.

### Uniqueness Validation

`:uniqueness` is what we'll pass to the `validates` method but apparently there is a major caveat to this practice.

So we have to do something unique in our tests, get it?

In order to make sure an email gets rejected because its already in the database, we of course, have to have an email in the database, so having a `User.new` isnt going to cut it.  

```ruby
test "should reject duplicate emails" do
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  @user.save
  assert_not duplicate_user.valid
  p duplicate_user.errors.messages
end
```

So, the whole point of this is to make sure that the dup_user's email is of a difference case as the original users, and then to make sure that the uniqueness check accounts for this.

```ruby
validates :email, presence: true,             length:{maximum:255},
                  format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
```

The problem with this is that we are enforcing uniqueness on a model level, but not down to the database level.

So if someone presses submit twice in very quick succession, then it's possible that both of those users will be saved in memory and will pass validation, as the uniqueness check checks against the database, so we need to make sure that when two identical users are passed into the database, one of them is deleted.

The way we will do this is by creating a database index on the email column, and making sure that each index is unique.

The way that we were planning on looking things up is that we have a big table of users, and when we want to allow someone to log in for example, we must find the corresponding user via their email address, which necessitates that we look through every user row by row, which is called a `full-table scan` and this is an O(n) time, which isn't terrible, but with a large database probably not ideal.

The index is basically a pointer to whatever you want to find.  For example, in a book, you look at the index for the term 'foobar' and it will give you back all the pages that have that.

In order to do this we must create a new migration.  Are we essentially creating like a new data structure within our model?

`rails g migration add_index_to_users_email`

I'm not sure if this directly adds the column but then we do this shit...

```ruby
class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
  end
end
```

Finally, `rails db:migrate`

After this, your tests should fail, rails provides `fixtures` with sample data that is not unique, so lets see.

```ruby
one:
  name: MyString
  email: MyString

two:
  name: MyString
  email: MyString
```

Those are the fixtures, we can just delete them for now.

Afterwards, all of my tests pass, yay

Some database adapters use case-sesitive indices, whereas all of our stuff is case insensitive.  To remove this incompatability, we're going to be convert all of the emails to lowercase.

We want to do this right before the emails are saved to the database, so we can use a callbook, a hook, to do something before a specific time in the lifecycle of an ActiveRecord object.  `before_save`...

So, in our `user` model we will add this line.

`before_save { self.email = email.downcase }`

In assignments, even though `self` is correct, you can't leave off `self`, but for whatever you're assigning it to, that's fine.

Let's do some testing to make sure that the downcase worked properly on the database level.

```ruby
test "email addresses should be saved as lower-case" do
  mixed_case_email = "Foo@ExaMpLe.coM"
  @user.email = mixed_case_email
  @user.save
  assert_equal @user.reload.email, mixed_case_email.downcase
  # they did this in the opposite order but it shouldn't matter right.
end
```

## Adding a secure password

We need to add a column which is a hashed version of the password to the user table as a column.  This is done by applying an irreversible hash function to an input.  Any given input will always output the same hashed outcome, but it would be nearly impossible to go back the other way.  

The great thing about using hashed data is that even if the database is compromised, the passwords will store be secure because it's just the hashed data!

### A hashed password

Rails has a built in method called `has_secure_password`

```ruby
class User < ApplicationRecord
  #...
  #...
  #...
  has_secure_password
end
```

When simply added to a model like so, you can some added functionality.

- The ability to save a securely hashed password_digest attribute to the database, (what the fuck does that mean)
- A pair of virtual attributes(`password` and `password_confirmation`), including presence validations upon objec t creation and a validation requiring that they match.
- An `authenticate` method that returns the user when the password is correct (and `false` otherwise)

The only other setup you need for `has_secure_password` to be eligible is for the model to have an attribute called `password_digest`

Hashed password == password digest

based on the words etymology.

And of course, when we are talking about attributes of models we are really talking about columns.

So first we must add a migration for the `password_digest` column to be added, when you add your migration with the `to_users` end, rails automatically prepares a migration to add specifically to the `Users` table.

`rails g migration add_password_digest_to_users password_digest:string`

This is the resulting migration file.

```ruby
class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end
```

Next, `rails db:migrate`

So, the has_secure_password uses `bcrypt` in order to hash the password, we just need to add it to our gemfile. It appears that I already have it there.

If I didn't have it, and you just added, make sure to `bundle install` that ish.

### User has secure password

Run your tests now that you have this added functionality ready and available.

```ruby
# you need to do add the passwords to your test user so that the tests don't just automatically fail.
def setup
  @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
end
```

### Minimum password standards

### Creating and Authenticating a user

First in a regular console session, lets make a new user.

it worked.

`has_secure_password` also adds an authenticate method to the corresponding model objects, so you can give Users different permissions.  It authenticates by checking the hashed version of whatever password the user enters in with the hash that is in the users table `password_digest` column.

```ruby
u.authenticate('hellothere')
# false.
u.authenticate('sample')
# => #<User id: 1, name: "Eric Uyemura", email: "euyemura@learn.edu", created_at: "2019-04-26 00:53:35", updated_at: "2019-04-26 00:53:35", password_digest: "$2a$10$/jHT3oZ/XukUY7Q0qBfm.eCVzYuvk1NK4CKrzUBV2ba...">
```

I forgot that i need to actually remember the password now shit.

I tried updating this user with update, and update attributes, and just reassigning, but it doesn't work because it doesnt pass validations, particularly that a password is required to save a record.

So, you  must use `update_attribute` to bypass validations.

Merge it to master, push it to heroku, migrate it in heroku, and open console sandbox in heroku to verify that it worked.

`heroku run rails console --sandbox`
