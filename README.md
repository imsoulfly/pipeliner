# Pipeliner

Easily create processing pipelines for contexts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pipeliner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pipeliner

## Usage

Simply including the `Pipeliner::Pipeline` into a class:
```
class Example
  include Pipeliner::Pipeline

  pipeline :do_something_1,
           :do_something_2

  def do_something_1(context)
    context.step1 = true
  end

  def do_something_2(context)
    context.processed_params = context.param_1.to_sym
  end
end

result = Example.call(param_1: "some_value")
pp result.step1
=> true

pp result.processed_params
=> some_value
```

Pipeliner gem can fail early and stop processing the pipeline and return an error state.

```
class ErrorExample
  include Pipeliner::Pipeline

  pipeline :do_something_1,
           :do_something_2

  def do_something_1(context)
    # Something went wrong
    fail!("Did uppsie!")
  end

  def do_something_2(context)
    context.done = true
  end
end


result = ErrorExample.call()
pp result.failure?
=> true

pp result.error
=> "Did uppsie!"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pipeliner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pipeliner project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pipeliner/blob/master/CODE_OF_CONDUCT.md).
