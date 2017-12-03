require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UcsbClassScheduler
	class Application < Rails::Application
		config.api_only = true
		# Initialize configuration defaults for originally generated Rails version.
		config.load_defaults 5.1

		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		config.after_initialize do
			if ENV["MASTER_PROC"] == "true"
				AggregateCoursesJob.perform_now
				exec("MASTER_PROC=false bundle exec clockwork lib/clock.rb") if fork.nil?
			end
		end
	end
end
