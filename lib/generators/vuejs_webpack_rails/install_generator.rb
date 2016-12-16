module VuejsWebpackRails
  # :nodoc:
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc "Install everything you need for a basic vuejs-webpack-rails integration"

    def run_webpack_rails
      generate "webpack_rails:install"
    end

    def copy_files
      directory 'config'
      directory 'webpack'
    end

    def modify_webpack_config
      inject_into_file 'config/webpack.config.js', after: /\s*var StatsPlugin.*/ do
        <<-EOF.strip_heredoc

        var merge = require('webpack-merge')
        var vueConfig = require('./vue.config')
        EOF
      end

      gsub_file 'config/webpack.config.js', /module.exports = config/ do
        'module.exports = merge(config, vueConfig)'
      end
    end

    def modify_package_json
      insert_into_file "package.json", before: /\s}\s$/ do
        <<-EOF.strip_heredoc
        ,
          "private": true,
          "engines": {
            "node": ">= 4.0.0",
            "npm": ">= 3.0.0"
          },
          "babel": {
            "presets": [
              "es2015"
            ],
            "plugins": [
              [
                "transform-runtime",
                {
                  "polyfill": false,
                  "regenerator": true
                }
              ]
            ]
          }
        EOF
      end
    end

    def modify_procfile
      gsub_file 'Procfile', %r{(config/webpack.config.js)\s*$}, '\1 --hot --inline'
    end

    def install_packages
      install_npm_packanges '-S', *%w(vue lodash vue-resource)
      install_npm_packanges '-D', *%w(webpack-manifest-plugin extract-text-webpack-plugin webpack-merge)
      install_npm_packanges '-D', *%w(babel-core babel-loader babel-runtime babel-plugin-transform-runtime babel-preset-es2015)
      install_npm_packanges '-D', *%w(coffee-loader coffee-script)
      install_npm_packanges '-D', *%w(css-loader style-loader node-sass sass-loader)
      install_npm_packanges '-D', *%w(exports-loader expose-loader file-loader url-loader imports-loader)
      install_npm_packanges '-D', *%w(vue-loader vue-hot-reload-api vue-template-compiler)
    end

    def print_message
      say <<-MESSAGE.strip_heredoc

      ==  Vuejs + Webpack + Rails  ==

      1. Please add below line to your layout(app/views/layouts/application.html),
        this is loading Vue assets from Webpack web server in development

          <% = javascript_include_tag *webpack_asset_paths('application') %>

      2. Now add your own Vue components to webpack/components/<your_component>,
      require your component from webpack/components/index.js

      MESSAGE
    end

    no_tasks do
      def install_npm_packanges(type, *packages)
        run "npm i #{packages.join(' ')} #{type}"
      end
    end
  end
end
