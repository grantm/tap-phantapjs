//
// Load the PhanTAP test builder library and any other helper libraries
// then run the test script supplied on the command-line.
//

phantom.injectJs('testlib.js');

// If you have project-specific helpers you might load them like this:
// phantom.injectJs('my-project-helpers.js');

// Now run the target test script named on the command-line
var system = require('system');
phantom.injectJs(system.args[1]);

