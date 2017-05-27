# README

[![Build Status](https://travis-ci.org/rubyforgood/loudoun_codes.svg?branch=master)](https://travis-ci.org/rubyforgood/loudoun_codes)

This is an attempt to create an open-source, MIT-license-friendly, content runner for HSPC-style and similar coding contests.

This project was born as a project at RubyforGood 2017.

Submission Runners
------------
A `SubmissionRunner` is used to compile and run the language of choice in order to score a `Submission`. `SubmissionRunners::Base` handles the logic for building docker containers used in compiling the language and running the submission. Each language's runner should inherit from `Base` and provide methods for the image, how to compile the language, and how to run it.

### \`docker_run\`
We are using [TTY::Command](https://github.com/piotrmurach/tty-command) to interface with the docker command line. `SubmissionRunners::Base` offers a `docker_run` method, which a language runner's `build` and `run` methods should utilize. `docker_run` accepts a splatted `command` parameter. This gets passed through to the docker container as its run command.

For example, a program `Foobar` is compiled via
```
$ javac Foobar.java
```

Acceptable inputs to `docker_run` might look like:
```
docker_run('javac', 'Foobar.java')
```

After compilation, running a class `Foobar` is accomplished with 
```
$ java Foobar
```

Acceptable inputs might look like:
```
docker_run('java', 'Foobar')
```

### \`source_file\`
The `#source_file` method returns a `SubmissionRunners::SourceFile` (`Pathname` subclass) instance bound to the `basename` of the participant-submitted source code file for this run. It responds to `#without_extension`, which returns an extension-less instance (helpful for compiler targets), as well as the entire `Pathname` "interface".


If your language doesn't need a build step (the vast majority of interpreted languages don't, for example), then you can omit a `#build` method for your runner.

Running tests
------------
```
$ bundle exec rake                # all specs
$ bundle exec rake ci             # all specs + rubocop
$ bundle exec rake minus_docker   # non-docker specs
$ bundle exec rake dev_specs      # non-docker specs + rubocop
```


Contributors
------------

* David Bock (dbock@loudouncodes.org, @bokmann), Team Lead
* Daniel P. Clark (6ftdan@gmail.com, @danielpclark)
* Brandon Rice (brandon@blrice.net, @brandonlrice)

(contributors, please add your information here.)

# Getting Started

1. Install [Ruby v2.4.1](https://www.ruby-lang.org/en/downloads)
2. Install (and start) [Redis](https://redis.io)
3. `mkdir -p /var/lib/milton` - You *must* ensure that the user running the app has permissions in this directory.
4. Install Docker `curl -fsSL https://get.docker.com/ | sh; sudo usermod -aG docker $(whoami)`
5. Pull docker images `rake docker`
6. `git clone https://github.com/rubyforgood/loudoun_codes.git`
7. `cd loudoun_codes`
8. `bundle install`
9. `bundle exec rake db:setup`
10. `bundle exec foreman start`

If you are running the application for an actual competition, you probably want to use `RAILS_ENV=production bundle exec foreman start` in step 7.

After starting the application, you will see this line (or something similar) in your output:

`14:25:13 web.1     | * Listening on tcp://0.0.0.0:5100`

Browse to the provided address and you will see the web application. Browse to `/sidekiq` to see statistics about currently running jobs.

# Future Deployment

The 'getting started' instructions are above are while this project is in active development.  A near-future goal of this project is to make deployment as brain-dead simple as possible.  We may, for instance, wrap this code in a mini custom linux distribution so it could be put on a thumb drive and take over a machine for the purpose of the running content.  We had previously considered a docker container mimicking the setup of the jenkins docker container, but considering our use of docker containers for the submission judging, we believe the inception scenario there would hurt our heads too much.
