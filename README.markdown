# jQuery csswatch event/plugin #
[http://github.com/leifcr/jquery-csswatch/](http://github.com/leifcr/jquery-csswatch)

With jQuery css-watch, you can watch css changes

It uses requestAnimationFrame _(webkitRequestAnimationFrame, mozRequestAnimationFrame, oRequestAnimationFrame, msRequestAnimationFrame)_ for polling and verifying if any changes to the CSS has been made for the given CSS attributes. It falls back to a timer in case the browser doesn't support requestAnimationFrame.

## Documentation ##
For now, please see the tests and examples

## Examples ##
A working example can be found here:
See [http://leifcr.github.com/jquery-csswatch/example/](http://leifcr.github.com/jquery-csswatch/example/)

## Requirements ##

* jQuery 1.8+

* execute_method (http://github.com/leifcr/execute_method) (Already included in this package)

## Development ##
Development is made in chrome and firefox on jQuery 1.8.2. Please fork, make a feature or bugfix branch and request a pull request. I'm sure there are bugs to be hunted down.

## Testing ##
Currently these jQuery versions and browsers has been tested:

### jQuery Versions ###
1.8.2

### Browsers Tested ###
* Chrome
* Internet Explorer 9 (Unit tests hang, example works)
* Firefox

### Unit Tests ###
http://leifcr.github.com/jquery-csswatch/unit/

## Release History ##

1.0 - (2012-11-22) Initial release

## License ##
Copyright (c) 2012 Leif Ringstad
Licensed under the freeBSD license.

Since it's free, please give me a thanks, beer, pizza, gadget or what you feel for.