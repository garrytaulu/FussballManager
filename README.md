# Fussball Manager

Fun project for the staff at Syple to experiment with new technologies. A basic web application that manages games played on a traditional Fussball table.

The deployed application can be found at (subject to change):
http://gemworld.herokuapp.com

## API Specification

The API specification can be found here:
http://goo.gl/10EmT

## Project setup/structure

This project uses the Ruby on Rails framework for its backend, and it deploys to Heroku.

### Setup

To develop this project you will need to setup an environment with Ruby, Rails, Heroku and PostgreSQL. The initial project has been created 
with Ruby 1.9.2, so it's probably safe to get that version (it's also the verion that the Heroku tutorial uses). Links are provided below:

* Ruby/Rails: http://rubyonrails.org/download
* Ruby DevKit (tdm version for Ruby 1.9.*): http://rubyinstaller.org/downloads/ (located under the heading Development Kit)
  and instructions for installing it: https://github.com/oneclick/rubyinstaller/wiki/development-kit
* Heroku Toolbelt: https://toolbelt.heroku.com/
* PostgreSQL: http://www.postgresql.org/download/

Once your environment is setup you can start devloping. First things first, clone the git repo and run the app to make sure it works. You can do this
by running the following commands:

1. `git clone https://github.com/iamgarry/FussballManager.git`
2. `cd FussballManager`
3. `bundle install` (This may not be required - or only requried once per machine)
4. `rails server`

This should start the application and make it available at http://localhost:3000.

### Structure

The Rails framework sets up a project template for us to use, which we will follow as closly as possible. Directories/files of note are listed below:

* app/, db/, log/, etc (every top level directory besides *public/*) - These dirs contains the bulk of the Rails backend app (the REST endpoints, REST documenations, etc)
* public/ - This dir contains the frontend app (the AngluarJS app, all client code). The idea is to keep this de-coupled 
			from the backend app completely (it's only communcation should be through the REST API)
* Gemfile - Ruby's dependancy managment
* Gemfile.lock - Specifies which gem versions where installed (required for Heroku deployment)
* Procfile - Heroku's deployment file, tells Heroku how to start the app

## Getting Started

This section should just be a place where people can put useful links to do with any new technology (Rails, AngluarJS, Heroku)

### Rails

* Rails command line guide (creating an app, code generation, starting a server, etc): http://guides.rubyonrails.org/command_line.html  
