# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Setting default url options
PolkamarketsApi::Application.default_url_options = PolkamarketsApi::Application.config.action_mailer.default_url_options
