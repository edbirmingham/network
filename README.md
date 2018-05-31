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
* Wondering how to setup a development environment?  See the [Super Easy](#super-easy-setup) setup instructions below.
* Want to learn about the technology being used?  See the [Rails Guides](http://guides.rubyonrails.org/).

## Super Easy Setup (Obsolete)
The original Cloud9 service is no longer available.  The AWS Cloud9 service does not automatically setup the Rails environment so the AWS Cloud9 setup instructions below should be used.

This setup uses Cloud9 for your development environment.  Cloud9 provides an online development environment and server for you to use.  All you need is a browser and good internet connection.  Everything else is available on Cloud9's site.
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
  * Scroll to the top of this page and click "fork" in the top right corner. 
* Setup Cloud9
  * Signup for [Cloud9 IDE](http://c9.io) with your Github Account
  * Goto the Repositories link in Cloud9 IDE
  * Select "Clone to edit" on *your* fork of Network.
    * Note, you may see two options for Network.  One is "edbirmingham/network", which you do not want to select.  The other is "*your name*/network" which is the correct repository to select.
    * Enter a workspace name, network will probably be fine.
    * Enter a description.
    * Choose the Rails Ruby template.
    * Click the "Create workspace" button.
  * Cloud9 will soon display the development environment.
  * In the bash tab (bottom of the screen), setup a git remote to the main project:
  ```
  git remote add upstream https://github.com/edbirmingham/network.git
  git pull upstream master
  ```
  * Setup auto start for postgres service
    * Click on the Gear icon in File browser (on the left). Check "Show Home in Favorites" and "Show Hidden Files"
    * In the top directory ~-. you will see the .profile (hidden file) open it for editing and put this in at bottom of the file....
    ```
    function ensureservice {
    service=$1
    if [[ ! $(ps -ef | grep -v grep | grep "$service" | wc -l) > 0 ]]
    then
    sudo service $service start
    fi
    }
    ensureservice postgresql
    ```
    * Click on the Gear icon in File browser (on the left). Uncheck "Show Home in Favorites" and "Show Hidden Files"
  * Copy `config/database.yml.example` to `config/database.yml` in your local directory. Edit the file if desired.
  * In the bash tab, install the Ruby gems used by the project and setup the data in the database by entering the following commands:
  ```
  bundle install
  rake db:setup
  ```
  > Note: If the command fails, you can restart the workspace by clicking in the top right corner where it says "Memory, CPU, and Disk". Then click restart in that menu. 

  * To start the app run the following from the command line:
  ```
  rails server -p $PORT -b $IP
  ```
  * To view the app in the browser, select Preview from the editor menu and then select Preview Running Application.  This will open the application in a tab of the editor.  Log into the application with email `jane.doe@example.com` and password `password`.
* Hack away
* Send lots of pull requests!!
* In order to get updates from the main project use the following command in the bash tab:
```
git pull upstream master
```

## AWS Cloud9 Setup
This setup uses AWS Cloud9 for your development environment.  Cloud9 provides an online development environment and server for you to use.  All you need is a browser and good internet connection.  Everything else is available on Cloud9.
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
  * Scroll to the top of this page and click "fork" in the top right corner. 
* Create or login to an [AWS](https://aws.amazon.com) account.  A credit card will be required when creating a new AWS account.
* Select the Cloud9 AWS service under Developer Tools to go to the Cloud9 management console.
* Create a Cloud9 environment for the Ed Network application.  The default settings should be a good starting point and are eligible for the free tier of service.  If you have not previously created a Network VPC, you will be directed to do so at this time.

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
