## Setup
1. Set your Slack API Key using environment

Publish your Slack API Token(lagacy-tokens) from https://api.slack.com/custom-integrations/legacy-tokens  
Set your local environment variables referring to [.env.local.sample](https://github.com/miyachik/Kiritori/blob/develop/.envrc.local.sample)  
This project recommend using [direnv](https://github.com/direnv/direnv). Install this and follow messages.  


2. Exec `bundle exec rake db:create` and `rails server`.
1. Input your slack message format `https://#{SLACK_TEAM}.slack.com/archives/#{CHANNEL_ID}/p#{MESSAGE_TIMESTAMP}`  
You can get this URL from `Message menu -> Copy URL.`
