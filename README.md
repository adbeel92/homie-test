# Homie Technical challenge
Technical challenge developed by Eduardo Arenas

## About the Project
This is an API for listings who get properties to be shown at theis sites

## Getting Started

### Built with

* Rails 6.1.2.1
* Ruby 2.7.2
* PostgreSQL 13.1

### Main gems used

* JWT [https://jwt.io](https://jwt.io)
* Rails admin [https://github.com/sferik/rails_admin/wiki](https://github.com/sferik/rails_admin/wiki)
* Rspec [https://rspec.info/](https://rspec.info/)

### Requirements

* [RVM](https://rvm.io). RVM with version [1.29.10](https://rvm.io/blog/2020/03/rvm-1-29-10)

### Installation

#### PostgreSQL

Using Homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
brew install postgres
```

#### RVM

Installing RVM

`\curl -sSL https://get.rvm.io | bash -s 1.29.10`

Installing Ruby 2.7.2 with RVM

`rvm install ruby-2.7.2`

#### Clone the repository

`git clone git@github.com:adbeel92/homie-test.git`

Creating a gemset (entering to the directory, the gemset will be created thanks to the files `.ruby-version` and `.ruby-gemset`)

`cd ./homie-test`

#### Bundler

```
gem install bundler -v 2.2.4
bundle install
```

#### Running the App

```
rails db:create
rails db:migrate
rails db:seed
rails server
```

Go to http://locahost:3000

## Usage

### API admin

Go to http://locahost:3000/admin if you could setup your localhost. Or go to https://homie-challenge.herokuapp.com

```
email: admin@homie.mx
password: adminpass
```

There are two listing accounts created: [Segundamano](https://www.segundamano.mx/) and [Inmuebles24](https://www.inmuebles24.com/), and you are able to create apps for them.

Let's create one listing app. Go to http://localhost:3000/admin/listing_app
- Click on `+ Add new`
- Select any listing account (Segundamano or Inmuebles24)
- Click on `Save`

The listing apps list will appear.
- Click on ⓘ of the first row

Now, the listing account selected has an API_KEY and API_SECRET. Using these, the listing account will have access to the API (such as properties data)
- *** Copy the `Api key` and `Api secret`. We will use them

### API

- Download [Postman](https://www.postman.com/downloads/)
- Sign in/up at Postman

Then, join to my postman team click on [here](https://app.getpostman.com/join-team?invite_code=8535635c84400e65440771df843fd9a3&ws=738f5e79-5bed-4cec-8ba0-3c1aecd825c1)

We are going to use the workspace: `Homie workspace`

- In the navigation bar located on right, click on `Environments`
- Click on `Globals`

You will see `api_version`, `api_key`, `api_secret` and `token`. We are going to change only `api_key` and `api_secret` under `CURRENT VALUE` column

- Put the values in `api_key` and `api_secret` (***)

Now, we are going to generate a token
- Click on `No environment` localted top right and select `localhost` if you could run in your localhost, otherwise select `heroku`
- Go to `Collections > Create Token` and click on `Send`

The token generated will persist as a global variable. Now you are able to use the API (rest of requests defined in Postman)
