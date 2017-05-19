## Install and Build CodeWars

```bash
git clone git@github.com:Codewars/codewars-runner-cli.git
cd codewars-runner-cli
docker pull codewars/base-runner
docker pull codewars/jvm-runner
make jvm
docker pull codewars/ruby-runner
make ruby
```

## Run Ruby Example

```bash
docker-compose run ruby_test
```
