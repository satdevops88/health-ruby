import React, { Component } from 'react'
import PropTypes from 'prop-types'
import ReactSlick from 'react-slick'

export default class Carousel extends Component {

  static propTypes = {
    arrows: PropTypes.bool,
    autoplay: PropTypes.bool,
    autoplaySpeed: PropTypes.number,
    dots: PropTypes.bool,
    fade: PropTypes.bool,
    infinite: PropTypes.bool,
    speed: PropTypes.number,
    slidesToShow: PropTypes.number,
    slidesToScroll: PropTypes.number
  }

  // TODO - these defaults are really just powering the homepage slideshow
  // Probably shouldn't be defaults always
  static defaultProps = {
    arrows: false,
    autoplay: true,
    autoplaySpeed: 5000,
    dots: false,
    fade: true,
    infinite: true,
    speed: 2000,
    slidesToShow: 1,
    slidesToScroll: 1
  }

  render() {
    return (
      <ReactSlick {...this.props}>
        {this.props.children}
      </ReactSlick>
    )
  }
}
