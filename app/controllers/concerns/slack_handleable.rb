module SlackHandleable
  extend ActiveSupport::Concern

  private

  def output_message(channel_name)
    client = Slack::Client.new
    users = Hash[client.users_list['members'].map { |m| [m['id'], m['name']] }]
    channels = Hash[client.channels_list['channels'].map { |channel| [channel['name'], channel['id']] }]
    messages = client.channels_history(channel: channels[channel_name])['messages']
    format_messages(messages, users)
  end

  def format_messages(messages, users)
    text = []
    messages.each do |message|
      user_name = users[message['user']]
      raw = message['text'].inspect
      text.push("  - #{user_name}: #{raw}")
    end
    text
  end
end
