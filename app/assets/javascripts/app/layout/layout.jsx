import { connect } from 'react-redux'
import { renderRoutes } from 'react-router-config'
import classNames from 'classnames'

import routes from 'app/routes'

import Navbar from './navbar'

const Layout = ({ route }) => {
  const shouldRenderContainer = true

  return (
    <div>
      { shouldRenderContainer && <Navbar /> }

      <div className={classNames({container: shouldRenderContainer})}>
        <div className={classNames({mtl: shouldRenderContainer})}>
          {renderRoutes(route.routes)}
        </div>
      </div>
    </div>
  )
}

export default Layout