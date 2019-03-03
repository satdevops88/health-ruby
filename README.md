# README

# README

## Running Locally
### This can be completely skipped if you prefer
We run the app locally using [puma-dev](https://github.com/puma/puma-dev). To setup on OSX:

* Install via homebrew: `brew install puma/puma/puma-dev`
* Run `sudo puma-dev -setup` to configure DNS settings
* Run `puma-dev -install -d test` to make the site accessible on the .test TLD
* Add an entry in your `~/.puma-dev` directory with `echo 3000 > ~/.puma-dev/healthiest-api`

### This cannot be skipped
To run the app locally, start up the local process with `foreman start -f Procfile.dev` and visit `http://healthiest.test` in your browser.

