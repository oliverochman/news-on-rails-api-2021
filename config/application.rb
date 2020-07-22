module NewsOnRailsApi2020
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', 
          headers: :any, 
          methods: %i[get post put delete],
          expose: %w(access-token expiry token-type uid client),
          max_age: 0
      end
    end
  end
end