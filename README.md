# Slack::Mail

`ActionMailer` inspired [Slack](slack.com) message objects.


## Usage

Add `gem 'slack-mail'` to your `Gemfile` and install it.

```ruby
# Basic usage.
Slack::Mail.new(text: "...").deliver_now

# Using `ActiveJob` to send async (if configured)
Slack::Mail.new(text: "...").deliver_later

# Monitor your Rails app
class ApplicationController
  rescue_from StandardError do |e|
    Slack::Mail.new(channel: "bots").attach_error(e).deliver_later
  end
end
```

Valid [mail attributes](https://github.com/jamesdabbs/slack-mail/blob/master/lib/slack/mail.rb#L14) are

* channel
* text
* username
* as_user
* parse
* link_names
* attachments
* unfurl_links
* unfurl_media
* icon_url
* icon_emoji

all as per the [Slack API](https://api.slack.com/methods/chat.postMessage) (or `ls Slack::Mail.new` if you've got [pry](http://pryrepl.org/))

### Configuring Send Strategies

By default, messages are "delivered" into an array at `Slack::Mail.deliveries`

To actually send them, you'll need to [configure an incoming webhook](https://api.slack.com/incoming-webhooks) and tell `Slack::Mail` about it

```ruby
Rails.application.configure do
  config.slack_mail.deliver_with :perform, webhook_url: ...
```

You can also opt-in to storing messages (e.g. in `config/environments/test.rb`)

```ruby
Rails.application.configure do
  config.slack_mail.deliver_with :store
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/slack-mail/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
