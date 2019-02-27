# RSPEC Testing

## Why Test Code?

1. Avoids regressions when new features are added.
2. Provides living documentation for the codebase.
3. Isolate specific problems or bugs.
4. Improve the quality of code, especially design.  This is Boris' favorite reason as to why to test code. Because you have to think and labor over how things are built.
5. Cut down developer time.


## RSpec Ecosystem

RSpec consists of three different Ruby Gems that are usually paired together.

1. rspec-core is the base library that organizes and runs tests.
2. rspec-expectations is the matcher library that implements assertions.
3. rspec-mocks is a library used to fake behavior of classes and objects.

You can use different expectations and mocks libraries if you want.

rspec-rails integrates RSpec with the ruby on rails web framework.

## Project Structure

Projects must have a spec directory or folder to house all the RSpect test files, the nested directories inside of the `spec` directory will mimic those of the `lib` or the `app` folder depending on if it's simply a ruby project or a rails project.

`knight.rb` will have a matching `knight_spec.rb` file


# Types of tests

1. E2E Tests (UI testing)
2. Integration Tests
3. Unit Tests (This is the base of the pyramid)

### Unit Tests

- Focus on individual units of code, a method, class, object, module, etc.  
- Elements are tested in isolation; the program is not tested well.
- The specs are easy to write and run fast.

### E2E Tests

- Focus on a feature and its interaction with the entire system. Logging in, putting in item shopping cart, checking out, and receiving a notification.
- Elements are tested together, lots of connection, and you'll be confident that the whole program is working.
- The specs are hard to write, brittle and run slow. If something breaks, you may not necessarily know where it broke, what tiny piece broke, that's probably the importance of the unit tests.


### Integration tests

- You're not testing the entire program, maybe just the shopping cart. not the whole customer flow.

### Manual tests

- That's a behavioral test

Remember, you do ALL of these tests.

## Starting a Project in RSPEC

`rspec --init`
lol

## TDD

Red, green, refactor.  

Write a test, have it fail, write the bare minimum code that makes it pass, and then refactor it such that the tests still don't break. 
