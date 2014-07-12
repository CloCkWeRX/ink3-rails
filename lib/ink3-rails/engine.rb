module Bootstrap
  module Rails
    class Engine < ::Rails::Engine
      initializer 'ink.assets.precompile' do |app|
        %w(css font imgs).each do |sub|
          app.config.assets.paths << root.join('vendor', 'assets', sub)
        end
      end
    end
  end
end