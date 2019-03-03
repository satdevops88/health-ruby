require('core-js/modules/es6.object.assign')

global.React = require('react')
global.ReactDOM = require('react-dom')
global.ReactDOMServer = require('react-dom/server')

// https://github.com/react-bootstrap/react-overlays/issues/188
// require('./patch/react-overlays')

global.App = require('./app').default