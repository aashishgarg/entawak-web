require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EntawakWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # unless Rails.env.development?
    #   config.middleware.use ExceptionNotification::Rack, email: {
    #       email_prefix: "[Entawak] [#{Rails.env}] ",
    #       sender_address: %{"Exception Notifier" <no-reply@headerlabs.com>},
    #       exception_recipients: %w{entawak@googlegroups.com},
    #       delivery_method: :smtp,
    #       smtp_settings: {
    #           address: 'smtp.gmail.com',
    #           port: 587,
    #           domain: 'headerlabs.com',
    #           user_name: 'exception@headerlabs.com',
    #           password: 'headerlabs',
    #           authentication: :plain,
    #           enable_starttls_auto: true
    #       }
    #   }
    # end


    unless Rails.env.development?
      config.middleware.use ExceptionNotification::Rack, email: {
          email_prefix: "[Entawak] [#{Rails.env}] ",
          :sender_address => %{"Exception Notifier" <no-reply@headerlabs.com>},
          :exception_recipients => %w{entawak@googlegroups.com},
          delivery_method: :smtp,
          smtp_settings: {
              address: 'smtp.gmail.com',
              port: 587,
              domain: 'headerlabs.com',
              user_name: 'exception@headerlabs.com',
              password: 'headerlabs',
              authentication: :plain,
              enable_starttls_auto: true
          }
      },
                            slack: {
                                webhook_url: "https://hooks.slack.com/services/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 ", # your webhook URL
                                username: 'entawak',
                                channel: "#entawak",
                                additional_parameters: {
                                    mrkdwn: true
                                }
                            }
    end


    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  end
end
