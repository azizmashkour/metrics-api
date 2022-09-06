# README

This README documents the steps necessary to get the metrics-api Ruby on Rails application up and running locally.

<!-- TOC -->

- [README](#readme)
- [Installation](#installation)
  - [Bundle dependencies](#bundle-dependencies)
  - [Install Ruby](#install-ruby)
  - [Install Node](#install-node)
  - [Setting up dependencies](#setting-up-dependencies)
  - [Clone repository](#clone-repository)
  - [Set up the database](#set-up-the-database)
  - [Install gems and yarn packages:](#install-gems-and-yarn-packages)
  - [Run the app](#run-the-app)
    - [Other commands to run](#other-commands-to-run)
  - [Run the tests](#run-the-tests)

<!-- /TOC -->

# Installation

This describes all that you need to make the app run successfully.

## Bundle dependencies

This includes all infrastructure dependencies ([besides nvm](#install-node)).
To install these required items,
first, make sure you have [homebrew installed and set up](https://brew.sh/).
Afterward, run the following command in the root of the repository:

```
brew bundle
```

## Install Ruby

Install [rbenv](https://github.com/rbenv/rbenv) and Ruby 2.7.6.

```
rbenv init
rbenv install 2.7.6
```

## Install Node

Install [nvm](https://github.com/nvm-sh/nvm#installing-and-updating) and Node 16.13.1

Install yarn

via `npm install --global yarn` (in your node's version)

or

via homebrew `brew install yarn`

## Setting up dependencies

Put PostgreSQL on the path (zsh example):

```
echo 'export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"' >> ~/.zshrc
```

To run on startup:

```
# to have launchd start postgresql now and restart at login
brew services start postgresql@12
brew services stop postgresql@12
brew services restart postgresql@12
```

## Clone repository

```
git clone git@github.com:azizmashkour/metrics-api.git && cd metrics-api
```

### Set up the database

Run rake tasks to create the schema and run any pending migrations.

```bash
bundle exec rake db:setup
bundle exec rake db:migrate
```

To add test data in development, run:

```
bundle exec rake db:seed
```

This will create a list of fake metrics to be populated and used in the Chart.js graph. Once this command is executed, the next time you may try to run it again, it automatically update the existing data instead of deleting them.

## Install gems and yarn packages

Since we are using some yarn packages and `ruby` gems, we need to install all of them by running the commands:

```
gem install bundler
bundle install
yarn install
```

## Run the app

To start the web server, run this command:

```
bundle exec rails server
```

Then open your browser to [http://localhost:3000](http://localhost:3000). You should see the home page of the metrics Api.

If your CSS is not loaded, ensure the run these commands and restart your server:

```
./bin/bundle add tailwindcss-rails
./bin/rails tailwindcss:install
```

### Other commands to run

There are some other common commands you'll want to run:

```
bundle exec rails console # interactive console
tail -f log/development.log
```

## Run the tests

To run the tests, run this command:

```
bundle exec rake spec
```

or

```
bundle exec rails spec
```

To set up the test databases needed to run:

```
RAILS_ENV=test bundle exec rake db:setup
```

## Other resources
[React Query](https://react-query-v3.tanstack.com/overview)
[ChartJS](https://www.chartjs.org/docs/latest/)
[TailwindCSS](https://tailwindcss.com/docs/guides/ruby-on-rails)
