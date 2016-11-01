# Security Bot

Bot that scans various security announcement feeds and sends slack notifications
for items that match rules. Rules are configured as regular expressions.

## Overview

There are many security lists, CVE's and other announcements in the wild which 
make it hard to see signal in the sea of noise. If you're a developer, there's a
chance that you alreay follow a few sources via email or rss. This bot is here to
automate a basic task of fetching and matching terms that you're interested in and
delivering them to a slack channel so everyone on your team can keep up to date.

## Requirements

- Git
- Ruby 2.1+

## Installation

Clone repository and install dependencies:

```
git clone git@github.com:doejo/security-bot.git
cd security-bot
bundle install
```

## Configuration

All configuration options are specified in YAML file. Example:

```yaml
# Slack webhook.
webhook: https://hooks.slack.com/services/slack-token

# Channel to deliver notifications to.
# If you want to send them to yourself, use "@username"
channel: "development"

# Format specifies the general structure of regular expression.
format: \s?RULE\s?

# Rules defined by regular expressions to match content.
# Any feed item that has a match will result in notification being sent to slack.
rules:
  - postgresql
  - mysql
  - redis
  - memcache
  - elasticsearch
  - wordpress
  - wp-core
  - wp-cli
  - php
  - rails
  - ruby
  - osx
  - docker

# Feeds specify a list of RSS feeds to process.
# You can add as many feeds as you'd like.
feeds:
  - http://seclists.org/rss/bugtraq.rss
  - http://seclists.org/rss/pen-test.rss

# Storage specifies file to keep track of matched items. Once the item is 
# processed, it will be logged into the items file.
storage: "./items.txt"
```

## Testing

Test configuration for syntax errors:

```
rake test
```

Test runner:

```
DEBUG=1 rake run
```

## Deployment

This project was created in a day so there was not any plans on rolling it out to
any hosting provider like Heroku. We're running it via cron job on a chep DigitalOcean
droplet. It works™.

Here's an example: (`crontab -e`)

```
*/5 * * * * bash -c "cd /home/deploy/security-bot && /usr/local/bin/bundle exec rake run >> /home/deploy/security-bot.log"
```

## Licens

MIT