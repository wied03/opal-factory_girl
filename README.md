# opal-factory-girl

[![Build Status](http://img.shields.io/travis/wied03/opal-factory_girl/master.svg?style=flat)](http://travis-ci.org/wied03/opal-factory_girl)

Allows the basics of [Factory Girl](https://github.com/thoughtbot/factory_girl/) to work on Opal.

## Usage

Add `opal-factory_girl` to your Gemfile:

```ruby
gem 'opal-factory_girl'
```

### Use in your application

Similar to normal FactoryGirl. This is mainly useful for assembling test view models/client side classes.

In your `spec_helper.rb` or equivalent file, add:

```ruby
require 'opal-factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```

Then for each factory file, do something like this:

```ruby
FactoryGirl.define do
  factory :currency_vm do
    skip_create # No persistence right now (see limitations)

    code 'USD'
    separator ','
    delimiter '.'
    symbol '$'
  end
end
```

You will need to `require` all of your factory files before using the factories in tests.

## Limitations:

* ActiveRecord support is not yet tested (thus you can't use the create strategy)
* ActiveSupport::Instrumentation is not tested
* Automatic population of `created_at` attributes is not tested since it uses time zone features
* Modifying existing factories with `FactoryGirl.modify` does not work
* When specifying the class for a new factory, use the class, not a string representing the class

## Contributing

Install required gems at required versions:

    $ bundle install

A simple rake task should run the example specs in `spec/`:

    $ bundle exec rake

## License

Authors: Brady Wied

Copyright (c) 2016, BSW Technology Consulting LLC
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

