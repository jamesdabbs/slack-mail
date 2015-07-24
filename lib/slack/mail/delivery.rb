module Slack
  class Mail
    DeliveryFailure = Class.new(StandardError)

    def self.deliveries
      @_deliveries ||= []
    end

    class Perform
      def initialize webhook_url:
        @notifier = Slack::Notifier.new webhook_url
      end

      def deliver message
        opts = message.to_h.reject { |_,v| v.nil? }
        text = opts.delete(:text) || " "

        response = @notifier.ping text, opts
        unless response.code == "200"
          raise DeliveryFailure, "Failed to reach #{@notifier.endpoint} (#{response.code})"
        end
        true
      end
    end

    class Store
      def deliver message
        Slack::Mail.deliveries.push message
      end
    end

  end
end
