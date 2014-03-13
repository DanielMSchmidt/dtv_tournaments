# DtvTournaments

A ruby gem for fetching tournaments from the dtv tournaments portal

## Installation

Add this line to your application's Gemfile:

    gem 'dtv_tournaments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dtv_tournaments

## Usage

Just call ``Dtv_tournament.get_by_number(number, options={})`` and you will get a hash like this returned

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
      cached: false
    }

## Contributing

1. Fork it ( http://github.com/DanielMSchmidt/dtv_tournaments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
