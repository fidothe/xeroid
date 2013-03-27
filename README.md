# Xeroid

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'xeroid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xeroid

## Usage

TODO: Write usage instructions here

Running the tests
-----------------

Some of the tests need to git the Xero API.

You'll need a Private application of your own for this. I recommend setting one up that points
at the Demo company: i.e. I recommend that you don't run these tests against your live Xero
organisation.

Create a file under `spec/` called `credentials.yml` that looks like:

```:yaml
consumer_key: YOURCONSUMER_KEY
consumer_secret: YOUR_CONSUMER_SECRET
private_key: ./path/to/your/private_key/relative/to/your/home/dir
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
