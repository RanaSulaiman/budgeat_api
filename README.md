# README

## Environment Set Up on OSX
### Install Homebrew Packager Manager
[Homebrew Package Manager](http://brew.sh) makes it easy to install a variety of software packages, and is used by the following Ruby Version Manager (rvm).  

Installing Homebrew involves copying and pasting `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

You may need to enter your computer password to complete the installation.

#### Trust but Verify
Run `$ brew doctor`. Brew is super great at telling you what else it may need. Sometimes there are file permissions to fix. Sometimes there's a warning that can be ignored. If there's anything ever wrong with Brew, `brew doctor` will usually be able to tell you what it is and how to fix it.

### Install Ruby Version Manager
[Ruby Version Manager (rvm)](https://rvm.io/) makes it easy to install, manage, and switch between Ruby versions. _rvm_ is a _package manager_; it's software to help us install other software. Most _package managers_ are just for installing, updating, and removing software packages, but _rvm_ has a lot of really useful features specifically for working with Ruby that we'll use throughout Ada.

Installing _rvm_ is done in the Terminal: `$ \curl -sSL https://get.rvm.io | bash -s stable`

The installation won't take long. When it's done, close your Terminal (⌘-Q) and then reopen it. You can find the ⌘ or 'Command' key next to your spacebar. On a Mac pressing both command and 'Q' will quit the active application.  

Verify all's well by running `$ rvm -v`. You should see something like `rvm 1.28.0 (latest)`.

### Install Ruby 2.4.0
Type the following into your terminal: `$ rvm install 2.4.0`

### Install Rails 5.0.4
Type the following into your terminal: `$ gem install rails`

### Create a Project Folder and Clone this Repo into it.

### Generate / Seed the data by  
Running `$ rails db:reset`

### Get API key for [Spoonacular-api](https://market.mashape.com/spoonacular/recipe-food-nutrition)

### Create environment variable for the key. Save it in an .env file then add the file to .gitignore.

### Check API documentation for request numbers per each plan.

### Start your Local Server by Running: `$ ./run_server.sh`

### Open the project in your browser at [http://localhost:4000/recipes](http://localhost:4000/recipes)

## Resources Used for this Project
[Setting up Rails with Postgres Database](https://github.com/Ada-Developers-Academy/textbook-curriculum/blob/master/08-rails/how-to-use-postgres.md)

[Memcache implementation](http://vinsol.com/blog/2014/02/11/guide-to-caching-in-rails-using-memcache/)  
