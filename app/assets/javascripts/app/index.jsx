import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { renderRoutes } from 'react-router-config'

import routes from 'app/routes'
import * as urls from 'app/urls'
import Router from 'lib/router'

export default class App extends Component {

  static propTypes = {
    url: PropTypes.string.isRequired
  }

  componentDidMount() {
    console.log('componentDidMount');
    const ReactPixel =  require('react-facebook-pixel');
    ReactPixel.init('567010577125623');

  }

  render() {
    return (
      <Router context={{}} location={this.props.url} onChange={this.handleRouteChange.bind(this)}>
        {renderRoutes(routes)}
      </Router>
    )
  }

  handleRouteChange(pathname) {
    this.updateGAMetrics(pathname)
    // Scroll to the top of the page
    window.scrollTo(0, 0)
  }

  updateGAMetrics(pathname) {
    if (window.ga) {
      ga('send', 'pageview', pathname)
    }
  }
}