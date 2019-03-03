import { StaticRouter } from 'react-router'
import { Router as DOMRouter } from 'react-router-dom'
import { createBrowserHistory } from 'history'

const canUseDOM = !!(
  (typeof window !== 'undefined' &&
  window.document && window.document.createElement)
)

const history = canUseDOM ? createBrowserHistory() : null

const ContextualRouter = ({ children, context, location, onChange }) => {
  let Router = canUseDOM ? DOMRouter : StaticRouter

  if (history) {
    history.listen((location, action) => {
      onChange && onChange(location.pathname)
    })
  }

  return (
    <Router context={context} history={history} location={location}>
      {children}
    </Router>
  )
}

export default ContextualRouter