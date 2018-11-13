## We're the Birmingham Education Foundation.
You can call us, [Ed](http://edbirmingham.org).

## What We Do
The unique and specific focus of our work is “[Network-Building](https://www.youtube.com/watch?v=OI0qip6XlZc)”. The Birmingham Education Foundation (Ed) is dedicated to increasing the number of students in the Birmingham City Schools that are on the path to college, career, and life readiness. We believe that this is only possible by cultivating a diverse network of people who demand excellence for our students and inspire others to do the same. We believe Network members are:

1. Committed to deliberate actions that demonstrate their belief in and love for our students; and
2. Intentionally connected through a set of relationships, taking advantage of opportunities to act together, 
and exchanging value between individuals and groups. 

To actively cultivate the Network, we provide direct programming for students and fun and interactive opportunities for Network members to build new relationships and strengthen existing ones. We serve as Connectors among five different stakeholder groups – students, educators, families, local residents, and community partners– bringing them together to create a new operating culture that sparks organic and objective-driven visions to increase student preparedness for college, career, and life.

## Network Asset Database [![Build Status](https://travis-ci.org/edbirmingham/network.svg)](https://travis-ci.org/edbirmingham/network)
In order to reach our Network membership and action goals it is imperative that we maintain organization of our data, communication, and progress. The Network Asset Database, aka [edbirmingham/network](https://github.com/edbirmingham/network), is being developed to increase Ed’s Network activity; maintaining Membership records, supporting stewardship (progress to requests/offers between Network members), and increasing access and awareness to school/community based assets.

## Contributing
Network is 100% free and open-source. We encourage and support an active, healthy community that accepts contributions from the public – including you!  To maximize openness we operate according to the [Collective Code Construction Contract](c4.md)
* Questions? Visit our [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/edbirmingham/network?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) room.
* Not sure what to work on?  Check out the [Stories in our Maintenance project](https://github.com/edbirmingham/network/projects/3).  When beginning work on an issue, please comment on the issue indicating that you are working on it. If you want a quick and easy issue to help you get started, check out out our [help-wanted](https://github.com/edbirmingham/network/projects/3?card_filter_query=label%3Ahelp-wanted) and [help-wanted-easy](https://github.com/edbirmingham/network/projects/3?card_filter_query=label%3Ahelp-wanted-easy) issues
* Wondering how to setup a development environment?  See the [AWS Cloud9](#aws-cloud9-setup) setup instructions below.
* Want to learn about the technology being used?  See the [Rails Guides](http://guides.rubyonrails.org/).

## AWS Cloud9 Setup
This setup uses AWS Cloud9 for your development environment.  Cloud9 provides an online development environment and server for you to use.  All you need is a browser and good internet connection.  Everything else is available on Cloud9.
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
  * Scroll to the top of this page and click "fork" in the top right corner. 
* Create or login to an [AWS](https://aws.amazon.com) account.  A credit card will be required when creating a new AWS account.
* Select the Cloud9 AWS service under Developer Tools to go to the Cloud9 management console.
* Create a Cloud9 environment for the Ed Network application.  The default settings should be a good starting point and are eligible for the free tier of service.  If you have not previously created a Network VPC, you will be directed to do so at this time.
* Setup database server with ec2-user.
  ```
  sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs postgresql-libs
  sudo service postgresql initdb
  sudo service postgresql start
  sudo su - postgres
  psql -U postgres
  CREATE USER "ec2-user" SUPERUSER;
  CREATE DATABASE "ec2-user" WITH OWNER "ec2-user";
  \q
  exit
  ```
* Setup auto start for postgres service and key for two factory authentication.
  * Click on the Gear icon in File browser (on the left). Check "Show Home in Favorites" and "Show Hidden Files"
  * In the top directory ~-. you will see the .bash_profile (hidden file) open it for editing and put this in at bottom of the file....
  ```
  export OTP_SECRET_ENCRYPTION_KEY=4e8332ae3fe1af0469d75516682aa9a6e5086ccff6c7b1a1d79e3bce197b9
  function ensurepostgres {
    if [[ ! $(ps -ef | grep -v grep | grep "postgres" | wc -l) > 0 ]]; then
      sudo service postgresql start
    fi
  }
  ensurepostgres
  ```
  * Click on the Gear icon in File browser (on the left). Uncheck "Show Home in Favorites" and "Show Hidden Files"
* Follow the Github SSH key setup instruction found [here](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-linux).
* Setup your git user information.
  ```
  git config --global user.name "<your name>"
  git config --global user.email <your email address>
  ```
* Clone the code repository from Github.
  ```
  git clone git@github.com:anthonycrumley/network.git
  cd network
  git remote add upstream https://github.com/edbirmingham/network.git
  git pull upstream master
  ```
* Setup the Rails application.
  ```
  bundle install
  cp config/database.yml.example config/database.yml
  rake db:setup
  ```
* Setup Rails run configuration.
  * Navigate the menu to Run > Run Configurations > New Run Configuration.
  * Enter Ed Network as the name.
  * Enter `rails s -b 0.0.0.0` as the command.
  * Click CWD and select the `network` folder that contains the git repo cloned from your fork of `edbirmingham/network`.
  * Click the Run button and the Rails application should start.
* Run the rails application.
  * Navigate the menu to Preview > Preview Running Application.
  * A preview tab will be opened in the Cloud9 environment but nothing will be displayed.  Click the "Pop Out Into New Window" button in the upper right hand corner of the preview tab and the application will open in a new browser tab.
  * Log into the application with email `jane.doe@example.com` and password `password`.
* Hack away
* Send lots of pull requests!!
* In order to get updates from the main project use the following command in the bash tab:
  ```
  git pull upstream master
  ```

### AWS Cloud9 Setup Problems
* History permission error when exiting `irb` similar to the following
  ```
  /usr/local/rvm/rubies/ruby-2.4.1/lib/ruby/2.4.0/irb/ext/save-history.rb:75:in `initialize': Permission denied @ rb_sysopen -   /usr/local/rvm/rubies/ruby-2.4.1/.irbrc_history (Errno::EACCES)
  ```
  * This problem occurs when exiting `irb` or `rails console`
  * This is caused by an rvm problem and can be resolved as follows.
  ```
  sudo -i
  rvm get head
  rvm reinstall 2.4.1
  exit
  ```
  * After this update, open a new terminal and `irb` history should work correctly.
