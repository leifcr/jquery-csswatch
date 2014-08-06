# jQuery csswatch event/plugin #
[http://github.com/leifcr/jquery-csswatch/](http://github.com/leifcr/jquery-csswatch)

With jQuery css-watch, you can watch css changes

It uses requestAnimationFrame _(webkitRequestAnimationFrame, mozRequestAnimationFrame, oRequestAnimationFrame, msRequestAnimationFrame)_ for polling and verifying if any changes to the CSS has been made for the given CSS attributes. It falls back to a timer in case the browser doesn't support requestAnimationFrame.

## Documentation ##
For now, please see the tests and examples

## Usage ##
This is both released as a bower component and a npm module, to suit whatever build tool/env you are using for your frontend.

### Using npm ###
```
npm install jquery-csswatch
```

```html
<script type="text/javascript" src="../node_modules/execute_method/dist/execute_method.js"></script>
<script type="text/javascript" src="../node_modules/jquery-csswatch/dist/jquery-csswatch.js"></script>
```

### Using bower ###

```
bower install jquery-csswatch
```

```html
<script type="text/javascript" src="../bower_components/execute_method/dist/execute_method.js"></script>
<script type="text/javascript" src="../bower_components/jquery-csswatch/dist/jquery-csswatch.js"></script>
```

## Building ##
You need to setup grunt + npm to develop/build
```
  # install dependencies
  npm install

  # Build library, run unit tests and create minified version
  grunt

```

## Examples ##
A working example can be found here:
See [http://leifcr.github.com/jquery-csswatch/examples/](http://leifcr.github.com/jquery-csswatch/examples/)

## Requirements ##

* jQuery 1.8+

* execute_method (http://github.com/leifcr/execute_method)

##### For building:

* CoffeeScript 1.4 + (For building the library)


## Development ##
Development is made in chrome and firefox on jQuery 2.x. Please fork, make a feature or bugfix branch and request a pull request.

## Testing ##

### jQuery Versions ###
* 1.8.x
* 1.9.x
* 2.1.x

### Browsers Tested ###
* Chrome 23
* Chrome SxS/Canary (25.0.1337 (169859))
* Internet Explorer 7,8,9
* Firefox
* Opera 11.6

### Unit Tests ###
http://leifcr.github.com/jquery-csswatch/unit/

## Release History ##
1.3.0 - (2014-08-06) Moved to npm/bower packaging. ExecuteMethod added as a dependency
1.2.1 - (2013-10-27) Improved version, using cake
1.0   - (2012-11-22) Initial release

## License ##
Copyright (c) 2012 Leif Ringstad
Licensed under the freeBSD license.

Since it's free, please give me a thanks, beer, pizza, gadget or what you feel for.