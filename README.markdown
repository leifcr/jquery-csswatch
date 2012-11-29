# jQuery csswatch event/plugin #
[http://github.com/leifcr/jquery-csswatch/](http://github.com/leifcr/jquery-csswatch)

With jQuery css-watch, you can watch css changes

It uses requestAnimationFrame _(webkitRequestAnimationFrame, mozRequestAnimationFrame, oRequestAnimationFrame, msRequestAnimationFrame)_ for polling and verifying if any changes to the CSS has been made for the given CSS attributes. It falls back to a timer in case the browser doesn't support requestAnimationFrame.

## Documentation ##
For now, please see the tests and examples

## Building ##
You need to install CoffeeScript before building.
```
  # Build library, tests and examples
  cake build

  # Build library
  cake build:library

  # Build tests
  cake build:tests

  # Build examples
  cake build:examples

  # Watch library for changes
  cake watch
  # or
  cake watch:library 

  # Watch tests
  cake watch:tests

  # Watch examples
  cake watch:examples

  # Build and run unit tests (needs a browser)
  cake test

```

## Examples ##
A working example can be found here:
See [http://leifcr.github.com/jquery-csswatch/examples/](http://leifcr.github.com/jquery-csswatch/examples/)

## Requirements ##

* jQuery 1.8+

* execute_method (http://github.com/leifcr/execute_method) (Already included in this package)

##### For building:

* CoffeeScript 1.4 + (For building the library)


## Development ##
Development is made in chrome and firefox on jQuery 1.8.2. Please fork, make a feature or bugfix branch and request a pull request. I'm sure there are bugs to be hunted down.

## Testing ##
The library and unit tests needs to be built before testing. Direct compilation of coffeescript fails in some rare cases, and it's therefore better to compile before testing.

Currently these jQuery versions and browsers has been tested:

### jQuery Versions ###
* 1.8.2

### Browsers Tested ###
* Chrome 23
* Chrome SxS/Canary (25.0.1337 (169859))
* Internet Explorer 7,8,9
* Firefox
* Opera 11.6

### Unit Tests ###
http://leifcr.github.com/jquery-csswatch/unit/

## Release History ##

1.0 - (2012-11-22) Initial release

## License ##
Copyright (c) 2012 Leif Ringstad
Licensed under the freeBSD license.

Since it's free, please give me a thanks, beer, pizza, gadget or what you feel for.