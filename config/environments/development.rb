# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Specify gems that this application depends on and have them installed with rake gems:install

# Annotate model comments with database table descriptions.
config.gem 'annotate', :version => '2.0.2'

# Performance analysis. Visit http://localhost:3000/newrelic
config.gem "newrelic_rpm", :version => '2.9.4'

# Capistrano deployment helpers to keep our recipe simple.
config.gem 'capistrano-helpers', :lib => false, :version => '0.3.2'
