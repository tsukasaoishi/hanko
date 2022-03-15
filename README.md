# Hanko

[![Gem Version](https://badge.fury.io/rb/hanko.svg)](http://badge.fury.io/rb/hanko) [![Code Climate](https://codeclimate.com/github/tsukasaoishi/hanko/badges/gpa.svg)](https://codeclimate.com/github/tsukasaoishi/hanko)

Hanko add a asset fingerprint in query string of Rails asset url(image, javascript, stylesheet, etc).  
Like this, ```/images/kaeruspoon.jpg?1af6d6f2f682f76f80e606aeaaee1680```  

Hanko would use when your rails app skipped Sprocket.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hanko'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanko

## Usage

The asset fingerprint of Hanko is Digest::SHA256 digest of asset file content.  
You could use Digest::Base class the asset fingerprint.  
For example ```config/application.rb```
```ruby
config.hanko.digest_class = Digest::MD5
```

If you would like to disable caching, sets false to ``config.hanko.cachable```.
```ruby
config.hanko.cachable = false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec appraisal rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tsukasaoishi/hanko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

