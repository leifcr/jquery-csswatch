fs = require 'fs'
{print} = require 'sys'
{spawn} = require 'child_process'

if !!process.platform.match(/^win/)
  coffeecmd = 'coffee.cmd'
else
  coffeecmd = 'coffee'

if !!process.platform.match(/^win/)
  opener = 'start'
else if process.platform == 'darwin'
  opener = 'open'
else


build = (directories, output, extra_options) ->
  args =  ['--compile']
  args = args.concat ['--output', output]

  if typeof extra_options == 'string'
    if extra_options != ''
      args.push(extra_options)
  else if typeof extra_options == 'object'
    if extra_options.length > 0
      args = args.concat extra_options

  if typeof directories == 'string'
    args.push(directories)
  else if typeof directories == 'object'
    if directories.length > 0
      args = args.concat directories
  else 
    print "Critical: Missing directories/files for input!"
    return

  coffee = spawn coffeecmd, args
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  # coffee.on 'exit', (code) ->
  #   callback?() if code is 0

task 'watch', 'Watch library for changes', ->
  invoke 'watch:library'

task 'watch:library', 'Watch only jquery-csswatch for changes', ->
  build(['./src/csswatch', './src/vendor'], 'lib', ['--watch', '--join','jquery.csswatch.js'])

task 'watch:tests', 'Watch unit tests for changes', ->
  build('src/unit', 'lib/unit', '--watch')

task 'watch:examples', 'Watch unit examples for changes', ->
  build('src/examples', 'lib/examples', '--watch')

task 'build', 'Build library, tests and examples', ->
  invoke 'build:library'
  invoke 'build:tests'
  invoke 'build:examples'

task 'build:library', 'Build library', ->
  print "Compiling library\n"
  build(['./src/csswatch', './src/vendor'], 'lib', ['--join','jquery.csswatch.js'])

task 'build:tests', 'Build library', ->
  print "Compiling tests\n"
  build('./src/unit', 'lib/unit', '')

task 'build:examples', 'Build examples', ->
  print "Compiling examples\n"
  build('./src/examples', 'lib/examples', '')

task 'test', ->
  invoke 'build:library'
  invoke 'build:tests'
  print 'Opening unit test file in default browser\n'
  open = require 'open'
  open './unit/index.html'

# task 'build:minified', 'Build minified version of library', ->
