require 'yaml'

unless Rails.env.production?
    yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'application.yml'))).result)
    APP_CONFIG = HashWithIndifferentAccess.new(yaml_data)

    ENV["GMAIL_DOMAIN"] = APP_CONFIG[:domain]
    ENV["GMAIL_USERNAME"] = APP_CONFIG[:gmail_username]
    ENV["GMAIL_PASSWORD"] = APP_CONFIG[:gmail_password]
end 