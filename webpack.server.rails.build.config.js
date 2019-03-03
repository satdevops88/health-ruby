// Run like this:
// npm run build:server
// Note that Foreman (Procfile.dev) has also been configured to take care of this.

const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

const config = require('./webpack.client.base.config');

const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

config.output = {
  filename: '[name]-bundle.js',
  path: './app/assets/javascripts/webpack',
};

// You can add entry points specific to rails here
config.entry = {
  server: [
  './app/assets/javascripts/components'
  ]
};

// No CommonsChunkPlugin
config.plugins = [
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify(nodeEnv),
    }
  }),
  new ExtractTextPlugin('[name]-bundle.css', { allChunks: true })
];

// See webpack.common.config for adding modules common to both the webpack dev server and rails

config.module.loaders.push(
  {
    test: /\.jsx?$/,
    loader: 'babel-loader',
    exclude: /node_modules/,
  },
  {
    test: /\.css$/,
    loader: ExtractTextPlugin.extract(
      'style',
      'css?minimize&modules&importLoaders=1&localIdentName=[name]__[local]__[hash:base64:5]' +
      '!postcss'
    ),
  },
  {
    test: /\.scss$/,
    loader: ExtractTextPlugin.extract(
      'style',
      'css?minimize&modules&importLoaders=3&localIdentName=[name]__[local]__[hash:base64:5]' +
      '!postcss' +
      '!sass' +
      '!sass-resources'
    ),
  },
  {
    test: require.resolve('react'),
    loader: 'imports?shim=es5-shim/es5-shim&sham=es5-shim/es5-sham',
  }
);

if (devBuild) {
  console.log('Webpack dev server build for Rails'); // eslint-disable-line no-console
  config.devtool = '#eval-source-map';
} else {
  console.log('Webpack production server build for Rails'); // eslint-disable-line no-console
}

module.exports = config;
