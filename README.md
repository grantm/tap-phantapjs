WARNING: This code is in very early stages of development.

This repository contains tools for running test scripts written in Javascript,
using Perl's `prove` command.  The Javascript runs inside of
[PhantomJS](http://phantomjs.org/) and uses a
[helper library](https://github.com/grantm/phantom-testlib) to generate TAP
output.

To run a .js file directly you can use the `phantap` script in the bin
directory of this distribution:

    phantap test-script.js

This does require some setup so use `phantap --help` for details (in
particular, the 'CONFIG' section).

To run a set of .js files via prove:

    prove -e phantap *.js

To run a set of test scripts that include both Perl (.t) files and Javascript
(.js) files, you need to load the appropriate plugin and register handlers
for the different file extensions:

    prove --source Perl --ext .t --source PhanTAPJS --ext .js t/

It is possible to put commonly used options in your `~/.proverc` file.
