# DtvTournaments

A ruby gem for fetching tournaments from the dtv tournaments portal. The gem only works with rails, because it's using the rails caching methods. Later on, they may be configured in a config file, so rails won't be necessary anymore.

## Installation

Add this line to your application's Gemfile:

    gem 'dtv_tournaments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dtv_tournaments

## Usage

Just call ``DtvTournaments.get_by_number(number, options={})`` and you will get a hash like this returned

    {
      address: {
        zip: ...,
        city: ...,
        street: ...
      },
      number: ...,
      time: ...,
      date: ...,
      datetime: ...,
      kind: ...,
      ageset: ...
    }

The default options are

    {
      cached: false, # If you want to get an uncached version but don't override the cached version
      rerun: false # If you want to override the cache
    }


## Todos
- migrate old code to project
- test old code


## Contributing

1. Fork it ( http://github.com/DanielMSchmidt/dtv_tournaments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
