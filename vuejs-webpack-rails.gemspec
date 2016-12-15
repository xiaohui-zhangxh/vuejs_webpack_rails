$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "vuejs/webpack/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "vuejs-webpack-rails"
  s.version     = Vuejs::Webpack::Rails::VERSION
  s.authors     = ["Xiaohui Zhang"]
  s.email       = ["xiaohui@zhangxh.net"]
  s.homepage    = "http://github.com/xiaohui-zhangxh/vuejs-webpack-rails"
  s.summary     = "Vuejs & Webpack & Rails integration made easier"
  s.description = "Production-tested, JavaScript-first tooling to use Vuejs + Webpack within your Rails application"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,example}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "railties", ">= 3.2.0"
  s.add_dependency "webpack-rails", ">= 0.9.9"
  s.add_development_dependency "rails", ">= 3.2.0"
  s.required_ruby_version = '>= 2.0.0'
end
