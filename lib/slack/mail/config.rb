module Slack
  class Mail
    def self.deliverers
      {
        perform: Perform,
        store:   Store
      }
    end

    def self.config
      @config ||= Slack::Mail::Configurator.new
    end


    class Configurator
      attr_reader :deliverer

      def initialize
        @deliverer = Slack::Mail::Store.new
      end

      def deliver_with name, *args
        @deliverer = Slack::Mail.deliverers.fetch(name).new *args
      end
    end
  end
end
