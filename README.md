# StickyNote

Easily memoize methods in Rails.cache.

## Installation

Add this line to your application's Gemfile:

    gem 'sticky_note'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sticky_note

## Usage

  include StickyNote

  memoize [:method1, :method2], expires_in: 2.minutes

This will cache the results of running the specified methods in Rails.cache for 
2 minutes.

## Contributing

1. Fork it ( http://github.com/neilberget/sticky_note/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
