module SlackHandleable
  extend ActiveSupport::Concern

  private

  def output_message(url)
    start_url = url['start']
    end_url = url['end']
    detail = start_url.match(%r{^https://(.+?).slack.com/archives/(.+?)/p(.+)})
    channel_name = detail[2]
    start_timestamp = (detail[3].to_f - 1).fdiv(1000000.0)
    end_timestamp = (end_url.match(%r{^https://(.+?).slack.com/archives/(.+?)/p(.+)})[3].to_f + 1).fdiv(1000000.0)
    client = Slack::Client.new
    users = Hash[client.users_list['members'].map { |m| [m['id'], m['name']] }]
    channels = Hash[client.channels_list['channels'].map { |channel| [channel['name'], channel['id']] }]
    messages = client.channels_history(
      channel: channels[channel_name],
      oldest: start_timestamp,
      latest: end_timestamp,
      count: 1000
    )['messages']
    format_messages(messages, users)
  end

  def format_messages(messages, users)
    text = []
    messages.each do |message|
      user_name = users[message['user']]
      raw = message['text']
      text.push("**#{user_name}** \n #{raw}")
    end
    text
  end
end
