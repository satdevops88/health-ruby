import { Helmet } from 'react-helmet'
import classNames from 'classnames'

import Navbar from 'app/layout/navbar'
import Carousel from 'lib/components/carousel'
import ChromeStoreButton from 'lib/components/chrome-store-button'

import * as css from './home.scss'

const SCREENSHOTS = [
  'https://res.cloudinary.com/healthiest/image/upload/v1516664158/1_bd0wo5.jpg',
  'https://res.cloudinary.com/healthiest/image/upload/v1516664158/2_m8ezjy.jpg',
  'https://res.cloudinary.com/healthiest/image/upload/v1516664158/3_ct6hhj.jpg',
  'https://res.cloudinary.com/healthiest/image/upload/v1516664158/4_mejwoq.jpg'
]

const Home = ({ route }) => {
  return (
    <div className={css.homeContainer}>
      <Helmet>
        <title>Healthiest - Sharing the healthiest options with you while you shop</title>
      </Helmet>

      <Navbar showLogo={false} />

      <div className={css.homeHeroContainer}>
        <h1 className={css.homeHeader}>Say hello to</h1>

        <div className={css.homeHero}>
          <div>
            <img
              className="img-responsive"
              src="https://res.cloudinary.com/healthiest/image/upload/v1516489582/hello_healthiest_helper_t4ibuj.png" />
          </div>
        </div>
      </div>

      <div className={classNames(css.homeCopyContainer, 'container')}>
        <ChromeStoreButton className="mtxl">
          <h4 className={classNames(css.homeDownloadLink, 'mtxs')}>download for free</h4>
        </ChromeStoreButton>

        <hr className="mvxl" />

        <h1>We all need that friend</h1>
        <p>You know the one who's always giving you great advice and suggesting the best products and newest trends. Don't you wish they were around when you needed them? Like when you're shopping online. Now they are. Healthiest Helper is your Amazon friend. Sharing the healthiest options with you while you shop. Here's how it works:</p>

        <div className={classNames(css.homeScreenShotContainer, 'mtxl')}>
          <Carousel>
            {
              SCREENSHOTS.map((imgSrc, idx) => (
                <div key={idx}>
                  <img src={imgSrc} />
                </div>
              ))
            }
          </Carousel>
        </div>

        <h1 className="mtxl">Yeah, it's that easy</h1>

        <ChromeStoreButton className="mtl">
          <h4 className={classNames(css.homeDownloadLink, 'mtxs')}>download for free</h4>
        </ChromeStoreButton>
      </div>
    </div>
  )
}

export default Home