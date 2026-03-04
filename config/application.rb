require "rails/all"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.yjit = true
  end
end
