[![Build Status](https://drone.io/github.com/DanielMSchmidt/dtv_tournaments/status.png)](https://drone.io/github.com/DanielMSchmidt/dtv_tournaments/latest)
[![Gem Version](https://badge.fury.io/rb/dtv_tournaments.svg)](http://badge.fury.io/rb/dtv_tournaments)
[![Code Climate](https://codeclimate.com/github/DanielMSchmidt/dtv_tournaments.png)](https://codeclimate.com/github/DanielMSchmidt/dtv_tournaments)

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

Call ``DtvTournaments::Tournament.new(number)`` to get an tournament instance with the the attributes

- number
- date / time / datetime
- street
- zip
- city
- kind
- notes

It provides also the methods

- rerun (to rerun the fetching process and update the cache)


## Todos
- fix that street and city is found by searching at the all tournaments page for the date and search there for the given number
- add tournament specific methods (is placing, get points, ...)


## Contributing

1. Fork it ( http://github.com/DanielMSchmidt/dtv_tournaments/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
