// Common client-side webpack configuration used by webpack.hot.config and webpack.rails.config.

const webpack = require('webpack');
const path = require('path');
const autoprefixer = require('autoprefixer');

const devBuild = process.env.NODE_ENV !== 'production';
const nodeEnv = devBuild ? 'development' : 'production';

module.exports = {

  // the project dir
  context: __dirname,
  entry: {

    // See use of 'vendor' in the CommonsChunkPlugin inclusion below.
    vendor: [
      'babel-polyfill',
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
    ],

    // This will contain the app entry points defined by webpack.rails.config
    app: [
      './app/assets/javascripts/components'
    ],

  },
  resolve: {
    extensions: ['', '.js', '.jsx'],
    alias: {
      react: path.resolve('./node_modules/react'),
      'react-dom': path.resolve('./node_modules/react-dom'),
    },
    root: [
      path.resolve('./app/assets/javascripts')
    ],
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(nodeEnv),
      }
    }),

    // https://webpack.github.io/docs/list-of-plugins.html#2-explicit-vendor-chunk
    new webpack.optimize.CommonsChunkPlugin({

      // This name 'vendor' ties into the entry definition
      name: 'vendor',

      // We don't want the default vendor.js name
      filename: 'vendor-bundle.js',

      // Passing Infinity just creates the commons chunk, but moves no modules into it.
      // In other words, we only put what's in the vendor entry definition in vendor-bundle.js
      minChunks: Infinity,
    }),
  ],

  module: {
    loaders: [],
  },

  // Place here all postCSS plugins here, so postcss-loader will apply them
  postcss: [autoprefixer],

  sassResources: [
    './app/assets/stylesheets/overrides/_variables.scss',
    './node_modules/bootstrap-sass/assets/stylesheets/bootstrap/_variables.scss',
    './app/assets/stylesheets/overrides/_mixins.scss'
  ],

  sassLoader: {
    includePaths: []
  }

};
