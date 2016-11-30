# RubyInstaller Chef Cookbook

This cookbook installs [RubyInstaller](http://rubyinstaller.org/) and the
[DevKit](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit) on
Windows machines

## CI

![Appveyor Build Status](https://ci.appveyor.com/api/projects/status/github/emachnic/chef-rubyinstaller?retina=true)

## Requirements

### Platform

This should work on any Windows platform but it's been tested under 2012R2 64-bit.
Right now, it does not support Ruby 1.8 or 1.9 because of the DevKit requirement.

## Usage

Include `recipe[rubyinstaller]` in your run list to install the latest versions of
Ruby and the DevKit.

## Recipes

### default

Installs RubyInstaller, downloads and extracts the DevKit, and links Ruby to the DevKit.

## Attributes

- `default['rubyinstaller']['version']` - Version of RubyInstaller to install. Defaults
to version '2.3.0'
- `default['rubyinstaller']['path']` - Path to install Ruby to. It's best to leave this
alone unless you change the installer version. The main thing is that this should be a
path without spaces.

## Development

* Source hosted at [GitHub][https://github.com/emachnic/chef-rubyinstaller]
* Report issues/Questions/Feature requests on [GitHub Issues][https://github.com/emachnic/chef-rubyinstaller/issues]

### Contributing

Pull requests are very welcome! Ideally create a topic branch for every
separate change you make.

This cookbook uses [ChefSpec][chefspec] for unit tests. I also use [Food
Critic][foodcritic] and [RuboCop][rubocop] to check for style issues.
When contributing it would be very helpful if you could run these via
`bundle exec rake spec` and `bundle exec rake rubocop`. You can also
just run all of them with `bundle exec rake`.

Lastly, there are [Inspec][inspec] integration tests for use
with [Test Kitchen][testkitchen]. At the very least the installation
integration tests should be run. You'll need a Windows box to test with
and you can find instructions for that on the Test Kitchen documentation.

## License and Author

Author:: [Evan Machnic][evanmachnic] (<emachnic@gmail.com>)

Copyright 2016, Evan Machnic

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[evanmachnic]:        https://github.com/emachnic
[chefsepc]:           https://github.com/sethvargo/chefspec
[foodcritic]:         https://github.com/acrmp/foodcritic
[rubocop]:            https://github.com/bbatsov/rubocop
[serverspec]:         https://github.com/serverspec/serverspec
[testkitchen]:        https://github.com/test-kitchen/test-kitchen
