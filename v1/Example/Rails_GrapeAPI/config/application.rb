require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Grape1
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

 	# for grape path
    # 	设置API路径，过滤所有rb文件
    # config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    # 	自动加载
    # config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

  end
end
