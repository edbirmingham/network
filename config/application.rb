require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.active_record.belongs_to_required_by_default = false
    
    # Prevent XSS attacks in emails
    config.x.allowed_html_tags_in_email = %w(strong em b a p i br style pre u h1 h2 h3 h4 h5 h6 font img ol ul)
    config.x.allowed_html_attributes_in_email = %w(src style href)
  end
end
