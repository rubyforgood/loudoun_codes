# README

[![Build Status](https://travis-ci.org/rubyforgood/loudoun_codes.svg?branch=master)](https://travis-ci.org/rubyforgood/loudoun_codes)

This is an attempt to create an open-source, MIT-license-friendly, content runner for HSPC-style and similar coding contests.

This project was born as a project at RubyforGood 2017.

Contributors
------------

* David Bock (dbock@loudouncodes.org, @bokmann), Team Lead
* Daniel P. Clark (6ftdan@gmail.com, @danielpclark)
* Brandon Rice (brandon@blrice.net, @brandonlrice)

(contributors, please add your information here.)

# Getting Started

1. Install [Ruby v2.4.1](https://www.ruby-lang.org/en/downloads)
2. Install (and start) [Redis](https://redis.io)
3. `git clone https://github.com/rubyforgood/loudoun_codes.git`
4. `cd loudoun_codes`
5. `bundle install`
6. `bundle exec rake db:setup`
7. `bundle exec foreman start`

If you are running the application for an actual competition, you probably want to use `RAILS_ENV=production bundle exec foreman start` in step 7.

After starting the application, you will see this line (or something similar) in your output:

`14:25:13 web.1     | * Listening on tcp://0.0.0.0:5100`

Browse to the provided address and you will see the web application. Browse to `/sidekiq` to see statistics about currently running jobs.
