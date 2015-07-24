require "slack-notifier"

require "slack/mail/config"
require "slack/mail/delivery"
require "slack/mail/job"
require "slack/mail/railtie"
require "slack/mail/version"

module Slack
  class Mail

    include Virtus.model

    attribute :channel, String, default: '#general'
    attribute :text
    attribute :username
    attribute :as_user
    attribute :parse
    attribute :link_names
    attribute :attachments
    attribute :unfurl_links
    attribute :unfurl_media
    attribute :icon_url
    attribute :icon_emoji

    def deliver_now
      Mail.config.deliverer.deliver self
    end

    def deliver_later
      Slack::Mail::Job.perform_later to_h
    end

    def attach_error error
      self.text        ||= error.to_s
      self.attachments ||= []

      trace = error.backtrace.join "\n"
      attachments.push \
        fallback:  trace,
        text:      "```#{trace}```",
        color:     "danger",
        mrkdwn_in: ["text"]

      self
    end

  end
end
