require "ink3-rails/version"
require "rails"

module Ink
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  class << self
    # Inspired by Kaminari
    def load!
      if rails?
        register_rails_engine
      end

      configure_sass
    end

    # Paths
    def gem_path
      @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
    end

    def stylesheets_path
      File.join assets_path, 'css'
    end

    def fonts_path
      File.join assets_path, 'fonts'
    end

    def assets_path
      @assets_path ||= File.join gem_path, 'app', 'assets'
    end

    # Environment detection helpers
    def asset_pipeline?
      defined?(::Sprockets)
    end

    def rails?
      defined?(::Rails)
    end

    private

    def configure_sass
      require 'sass'

      ::Sass.load_paths << stylesheets_path

      # bootstrap requires minimum precision of 10, see https://github.com/twbs/bootstrap-sass/issues/409
      ::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max
    end

    def register_rails_engine
      require 'ink3-rails/engine'
    end
  end
end
