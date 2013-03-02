# Fussball Manager

Fun project for the staff at Syple to experiment with new technologies. A basic web application that manages games played on a traditional Fussball table.

The deployed application can be found at (subject to change):
http://gemworld.herokuapp.com

## API Specification

The API specification can be found here:
http://goo.gl/10EmT

## Project setup/information

This project uses the Ruby on Rails framework for its backend, and it deploys to Heroku.

### Setup

To develop this project you will need to setup an environment with Ruby, Rails, Heroku and PostgreSQL. The initial project has been created 
with Ruby 1.9.2, so it's probably safe to get that version (it's also the verion that the Heroku tutorial uses). Links are provided below:

* Ruby/Rails: http://rubyonrails.org/download, p.s. you may also need the DevKit (I did), you can find it here: http://rubyinstaller.org/downloads/ 
 (located under the heading Development Kit) and instructions for installing it are here: https://github.com/oneclick/rubyinstaller/wiki/development-kit
* Heroku Toolbelt: https://toolbelt.heroku.com/
* PostgreSQL: http://www.postgresql.org/download/

### Information

Once your environment is setup you can start devloping. First things first, clone the git repo and run the app to make sure it works. You can do this
by running the following two commands:

```
git clone https://github.com/iamgarry/FussballManager.git
rails server
```

This should start the application and make it available at http://localhost:3000.

#### Project Structure

The idea is to have two top level folders called 'server' and 'client'. 'server' will contain all the backend (Rails) code, and 'client' will contain the
frontend (AngluarJS) code. The root dir has attempted to be kept as clean as possible, and a description of each top level file/folder follows:

* script/ - This dir contains the 'rails' script that is referenced in the Procfile (and in the command 'rails server'), *See below*
* server/ - Contains backend code
* client/ - Contains frontend code
* .gitignore - Standard git ignore
* Gemfile - Ruby's dependancy managment
* Gemfile.lock - Required for Heroku deployment
* Procfile - Heroku's deployment file, tells Heroku how to start the app
* README.md - This file

Notes:

To create a new Rails application, you use the command `rails new *dir*` which creates a full project scaffold. This scaffold references various config files that
are required to start the application correctly. In order for us to have the Rails app under the 'server' dir, and still be runnable by Heroku, we need the 'script'
dir in the root AND we need to modify the 'script/rails' file to reference the new config file location., i.e.:

```
APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)
```

needs to be changed to:

```
APP_PATH = File.expand_path('../../**server/**config/application',  __FILE__)
require File.expand_path('../../**server/**config/boot',  __FILE__)
```