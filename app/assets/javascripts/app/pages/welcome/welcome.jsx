import { Helmet } from "react-helmet"
import classNames from 'classnames'
import ReactPixel from 'react-facebook-pixel';

import { DefaultButton } from 'lib/components/buttons'
import { AMAZON_AFFILIATE_TAG } from 'lib/constants'

import * as css from './welcome.scss'

const Welcome = ({ route }) => (
  <div className={css.welcomeContainer}>
    <Helmet>
      <title>Welcome to Healthiest</title>
    </Helmet>
    
    <h1>Time to get Healthiest</h1>
    <h3>Let's see it in action on Amazon</h3>

    <div className={css.chooseToStartText}>Choose one of these items to start</div>

    <ul className={classNames(css.itemButtonList, 'list-inline list-unstyled')}>
      <li><DefaultButton href={`https://www.amazon.com/dp/B00L3JTHME?tag=${AMAZON_AFFILIATE_TAG}`} rounded target="_blank">Probiotics</DefaultButton></li>
      <li><DefaultButton href={`https://www.amazon.com/dp/B01EKZO93O?tag=${AMAZON_AFFILIATE_TAG}`} rounded target="_blank">Diapers</DefaultButton></li>
      <li><DefaultButton href={` https://www.amazon.com/dp/B000QSNYGI?tag=${AMAZON_AFFILIATE_TAG}`} rounded target="_blank">Protein Shakes</DefaultButton></li>
    </ul>

  </div>
)

export default Welcome