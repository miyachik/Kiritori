module SlackHandleable
  extend ActiveSupport::Concern

  private

  def output_message(url)
    start_url = url['start']
    end_url = url['end']
    detail = start_url.match(%r{^https://(.+?).slack.com/archives/(.+?)/p(.+)})
    channel_id = detail[2]
    start_timestamp = (detail[3].to_f - 1).fdiv(1000000.0)
    end_timestamp = (end_url.match(%r{^https://(.+?).slack.com/archives/(.+?)/p(.+)})[3].to_f + 1).fdiv(1000000.0)
    client = Slack::Client.new
    users = Hash[client.users_list['members'].map { |m| [m['id'], m['name']] }]
    channels = Hash[client.channels_list['channels'].map { |channel| [channel['id'], channel['name']] }]
    messages = client.channels_history(
      channel: channel_id,
      oldest: start_timestamp,
      latest: end_timestamp,
      count: 1000
    )['messages']
    format_messages(messages, users)
  end

  def format_messages(messages, users)
    text = ''
    messages.reverse_each do |message|
      user_name = users[message['user']]
      raw = message['text']
      replies = raw.scan(/(<@[A-Z0-9]*>)/)
      replies.each  do |reply|
        user_id = reply[0].delete("@<>")
        raw.gsub!(/#{reply[0]}/,"@#{users[user_id]}")
      end
      text += "**#{user_name}** \n #{raw}\n"
    end
    text
  end
end
