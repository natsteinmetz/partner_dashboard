# Partner Dashboard 

Partner Dashboard was the final Code Fellows class project created by Sean Irby and James Adney. It's been followed up with another Code Fellows class project by Kangie Chan, Nathalie Steinmetz and Danielle Tucker.

## Project Setup

_How do I, as a developer, start working on the project? What dependencies does it have and how do I install them?_

When you try to run 'bundle install' on the project, you will run into an error. You require the capybara-webkit gem, which depends on a WebKit implementation from Qt (version >= 4.8), a cross-platform development toolkit. You can follow the instructions on https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit to install Qt and compile capybara-webkit. For Mac users, please make sure to install Qt via homebrew.

After installing Qt, run 'bundle install' as usual.

Then run db:setup [1], and you should be good to go! Have a look in the db/seeds.rb for the development login credentials.




[1] Rake db:setup is used when you are setting up a new db on your app - it is a shortcut for running rake db:create; rake db:schema:load, and rake db:seed.
