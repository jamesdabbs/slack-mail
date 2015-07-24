module Slack
  class Mail
    class Railtie < Rails::Railtie
      config.slack_mail = Slack::Mail.config
    end
  end
end
