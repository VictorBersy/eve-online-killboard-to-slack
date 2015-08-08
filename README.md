# Eve Online : Zkillboard to Slack (open to others services)

`eve-online-killboard-to-slack` is a little project, written in Ruby.

It allows you to receive losses and kills, retrieved from Zkillboard, and throw the results to another service.

I developed it for our corporation's Slack Team, but I figured out it was a good idea to add an easy way to connect it to others services.

## Examples

### Slack

![Slack Example](https://raw.githubusercontent.com/VictorBersy/eve-online-killboard-to-slack/master/screenshots/slack_example.png)

### CLI

![CLI Example](https://raw.githubusercontent.com/VictorBersy/eve-online-killboard-to-slack/master/screenshots/cli_example.png)

https://github.com/VictorBersy/eve-online-killboard-to-slack/blob/master/screenshots/slack_example.png



## How to install and configure it

- Clone the repository
- Install ruby
- `bundle install` at the root of the repo
- `cp config/config.yml.example config/config.yml`
- `cp config/database.yml.example config/database.yml`
- `crontab -e`
- `*/10 * * * * ruby /PATH/TO/THE/REPO/eve-online-killboard-to-slack/bin/eve_online_killboard_to_slack` => check every 10 minutes for new kills and losses
