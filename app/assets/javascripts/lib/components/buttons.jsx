import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import BSButton from 'react-bootstrap/lib/Button'
import BSButtonGroup from 'react-bootstrap/lib/ButtonGroup'
import { isArray, omit } from 'lodash'

export class Button extends Component {
  static propTypes = {
    active: PropTypes.bool,
    block: PropTypes.bool,
    className: PropTypes.string,
    disabled: PropTypes.bool,
    href: PropTypes.string,
    onClick: PropTypes.func,
    rounded: PropTypes.bool,
    size: PropTypes.oneOf(['lg', 'large', 'sm', 'small', 'xs', 'xsmall']),
    submitting: PropTypes.bool,
    type: PropTypes.string,
    variant: PropTypes.oneOf(['danger', 'default', 'info', 'link', 'primary', 'success', 'warning'])
  }

  render() {
    // let children = isArray(this.props.children) ? this.props.children : [this.props.children]
    let disabled = this.props.disabled
    if (this.props.submitting) {
      // children.unshift(<i key={'spin-icon'} className={classNames('fa', 'fa-pulse', 'fa-spinner')} style={{marginRight: 5}}></i>)
      disabled = true
    }

    let buttonProps = {
      ...omit(this.props, ['submitting', 'variant']),
      bsStyle: this.props.variant,
      bsSize: this.props.size,
      className: classNames(this.props.className, { rounded: this.props.rounded }),
      // children: children,
      disabled: disabled
    }

    return (
      <BSButton {...buttonProps} />
    )
  }
}

export const InfoButton = (props) => (
  <Button variant='info' {...props} />
)

export const PrimaryButton = (props) => (
  <Button variant='primary' {...props} />
)

export const DefaultButton = (props) => (
  <Button variant='default' {...props} />
)

export class ButtonGroup extends Component {
  static propTypes = {
    className: PropTypes.string,
    rounded: PropTypes.bool
  }

  render() {
    return (
      <BSButtonGroup className={classNames(this.props.className, { rounded: this.props.rounded })}>
        {this.props.children}
      </BSButtonGroup>
    )
  }
}