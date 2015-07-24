module Slack
  class Mail
    class Job < ActiveJob::Base
      queue_as :default

      def perform attrs
        Slack::Mail.new(attrs).deliver_now
      end
    end
  end
end
