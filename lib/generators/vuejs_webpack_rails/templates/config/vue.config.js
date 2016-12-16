var config = {
  resolve: {
    extensions: ['', '.js', '.coffee', '.vue', '.json'],
    alias: {
      vue: 'vue/dist/vue'
    }
  },

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: 'babel',
        exclude: /node_modules/
      },
      { test: /\.vue$/, loader: 'vue' },
      { test: require.resolve('vue/dist/vue'), loader: 'expose?Vue'}
    ]
  },
  vue: {
    postcss: [
      require('autoprefixer')({
        browsers: ['last 2 versions']
      })
    ]
  }
}

module.exports = config;

