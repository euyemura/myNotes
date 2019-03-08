## Gemfile stuff

`gem 'sqlite3'` Bundler will install the latest version of the gem.

`gem 'uglifier', '>= 1.3.0'`  This installs latest gem as long as that version number is greater than or eqal to 1.3.0, it can be anything higher than that, version 6.9.0

`gem 'coffee-rails', '~> 4.0.0'` This will install the gem as long as its version 4.0.0 or newer, but not newer or equal to 4.1.0.  This is the what he recommends for more advanced users.


If you have a file that you did something naughty in, like deleted a directory or what have you, you can always use the command `git checkout -f` to override any changes that you had made to the most recently committed version.

When you are done with a branch you can delete it like so ..

`git branch -d modify-README` or whatever is the branch name.

This works only if you have merged the changes to the master branch.

Otherwise

`git branch -D topic-branch`  this will allow you to delete a branch even if you haven't merged those changes. 
