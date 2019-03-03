import React from 'react'
import { Link } from 'react-router-dom'
import { LinkContainer } from 'react-router-bootstrap'

import BSNav from 'react-bootstrap/lib/Nav'
import BSNavbar from 'react-bootstrap/lib/Navbar'
import BSNavItem from 'react-bootstrap/lib/NavItem'

import * as urls from 'app/urls'
import HealthiestLogo from 'lib/components/healthiest-logo'

import css from './navbar.scss'

const Navbar = ({ showLogo }) => {
  if (showLogo == undefined) {
    showLogo = true
  }

  return (
    <BSNavbar className="mbn">
      <BSNavbar.Header>
        <BSNavbar.Brand>
          { showLogo && <Link to={urls.rootPath}><HealthiestLogo color="#FFFFFF" height={48} width={40} /></Link> }
        </BSNavbar.Brand>
        <BSNavbar.Toggle />
      </BSNavbar.Header>

      {/*<BSNavbar.Collapse>
        <BSNav pullRight>
          <BSNavItem eventKey={1} href={urls.storePath}>Store</BSNavItem>
        </BSNav>
      </BSNavbar.Collapse>*/}
    </BSNavbar>
  )
}

export default Navbar