// TODO - read this file and generate valid route entries in Rails so we can
// do server side 404

import * as urls from 'app/urls'

import Layout from 'app/layout'

import NotFound from 'app/errors/not-found'

import Home from 'app/pages/home'
import Welcome from 'app/pages/welcome'

const routes = [
  {
    path: urls.rootPath,
    exact: true,
    component: Home
  },
  {
    component: Layout,
    routes: [
      {
        path: urls.welcomePath,
        exact: true,
        component: Welcome
      },
      {
        component: NotFound
      }
    ]
  }
]

export default routes