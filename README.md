## We're the Birmingham Education Foundation.
You can call us, [Ed](http://edbirmingham.org).

## What We Do
The unique and specific focus of our work is “[Network-Building](https://www.youtube.com/watch?v=OI0qip6XlZc)”. The Birmingham Education Foundation (Ed) is dedicated to increasing the number of students in the Birmingham City Schools that are on the path to college, career, and life readiness. We believe that this is only possible by cultivating a diverse network of people who demand excellence for our students and inspire others to do the same. We believe Network members are:

1. Committed to deliberate actions that demonstrate their belief in and love for our students; and
2. Intentionally connected through a set of relationships, taking advantage of opportunities to act together, 
and exchanging value between individuals and groups. 

To actively cultivate the Network, we provide direct programming for students and fun and interactive opportunities for Network members to build new relationships and strengthen existing ones. We serve as Connectors among five different stakeholder groups – students, educators, families, local residents, and community partners– bringing them together to create a new operating culture that sparks organic and objective-driven visions to increase student preparedness for college, career, and life.

## Network Asset Database
In order to reach our Network membership and action goals it is imperative that we maintain organization of our data, communication, and progress. The Network Asset Database, aka [edbirmingham/network](https://github.com/edbirmingham/network), is being developed to increase Ed’s Network activity; maintaining Membership records, supporting stewardship (progress to requests/offers between Network members), and increasing access and awareness to school/community based assets.

## Contributing
Network is 100% free and open-source. We encourage and support an active, healthy community that accepts contributions from the public – including you!
* Questions? Visit our [slack](https://magiccitytech.slack.com/messages/edbirmingham/) channel.
* Not sure what to work on?  Check out the [![Stories in Ready](https://badge.waffle.io/edbirmingham/network.svg?label=ready&title=Ready)](http://waffle.io/edbirmingham/network) issues at [waffle](https://waffle.io/edbirmingham/network). Please move issues to the [waffle](https://waffle.io/edbirmingham/network) "In Progress" column when you begin working on them.
* Wondering how to setup a development environment?  See the [Super Easy](#super-easy-setup), [Not Too Difficult](#not-too-difficult-setup) and [Really Difficult](#really-difficult-setup) setup instructions below.
* Want to learn about the technology being used?  See the [Built with MEAN.JS](#built-with-meanjs) section below.
* Please use the [Official Yo Generator](http://meanjs.org/generator.html) when adding functionality.

## Super Easy Setup
This setup uses Cloud9 for your development environment.  Cloud9 provides an online development environment and server for you to use.  All you need is a browser and good internet connection.  Everything else is available on Cloud9's site.
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
  * Scroll to the top of this page and click "fork" in the top right corner. 
* Setup Cloud9
  * Signup for [Cloud9 IDE](http://c9.io) with your Github Account
  * Goto the Repositories link in Cloud9 IDE
  * Select "Clone to edit" on *your* fork of Network.
    * Note, you may see two options for Network.  One is "edbirmingham/network", which you do not want to select.  The other is "*your name*/network" which is the correct repository to select.
  * Cloud9 will soon display the development environment.
  * In the bash tab (bottom of the screen), setup a git remote to the main project:
  ```
  git remote add upstream https://github.com/edbirmingham/network.git
  ```
  * In the bash tab, install Node.js modules by entering the following command:
  ```
  npm install
  ```
  > Note: If the command fails, you can restart the workspace by clicking in the top right corner where it says "Memory, CPU, and Disk". Then click restart in that menu. 

  * In the bash tab, setup MongoDb by entering the following commands:
  ```
  mkdir /home/ubuntu/workspace/mongo
  mongod --dbpath /home/ubuntu/workspace/mongo --smallfiles --fork --logpath /home/ubuntu/workspace/mongo/mongod.log
  ```
  * In the bash tab, start the application by entering the following command:
  ```
  grunt
  ```
  * To view the app in the browser, select Preview from the editor menu and then select Preview Running Application.  This will open the application in a tab of the editor.
* Hack away
* Send lots of pull requests!!
* In order to get updates from the main project use the following command in the bash tab:
```
git pull upstream master
```

## Not Too Difficult Setup
This setup uses Vagrant to create a virtual machine for the development environment.  The virtual machine runs on your computer.  Therefore you will need a good computer with plenty of memory and hard-disk space. The virtual machine keeps all the development safely isolated to avoid conflicts with other stuff on your computer.
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
* Install VirtualBox
* Install Vagrant
* Clone your forked Network repo
```
git clone git@github.com:<your-github-id>/network.git
```
* Change to the directory containing Network
* If librarian-chef is not installed:
```
gem install librarian-chef
```
* Download the Chef cookbooks
```
librarian-chef install
```
* Start Vagrant virtual machine
```
vagrant up
```
* SSH into the Vagrant virtual machine
```
vagrant ssh
```
* Run the application
```
grunt
```
* Open the application in your browser
```
http://localhost:3000
```
* Read documentation about [Official Yo Generator](http://meanjs.org/generator.html) for MEAN
* Hack away
* Send lots of pull requests!!

## Really Difficult Setup
This setup is for those who want complete control of their development environment, love wrestling with install scripts and who refer to dependency resolution as "Dependency Heaven".
* Look at the Vagrantfile and install all that stuff.  Good luck.  :)

## Built with MEAN.JS
Network is built on the MEAN.JS stack.  It is Javascript all the way down folks.  If you are unfamiliar with this stack or any of its individual parts, there are documentation links below.

[![MEAN.JS Logo](http://meanjs.org/img/logo-small.png)](http://meanjs.org/)

MEAN.JS is a full-stack JavaScript open-source solution, which provides a solid starting point for [MongoDB](http://www.mongodb.org/), [Node.js](http://www.nodejs.org/), [Express](http://expressjs.com/), and [AngularJS](http://angularjs.org/) based applications. The idea is to solve the common issues with connecting those frameworks, build a robust framework to support daily development needs, and help developers use better practices while working with popular JavaScript components. 

## MEAN.JS Building Blocks
Before you begin we recommend you be familiar with the basic building blocks that assemble a MEAN.JS application: 
* MongoDB - Go through [MongoDB Official Website](http://mongodb.org/) and proceed to their [Official Manual](http://docs.mongodb.org/manual/), which should help you understand NoSQL and MongoDB better.
* Express - The best way to understand express is through its [Official Website](http://expressjs.com/), which has a [Getting Started](http://expressjs.com/starter/installing.html) guide, as well as an [ExpressJS Guide](http://expressjs.com/guide/error-handling.html) guide for general Express topics. You can also go through this [StackOverflow Thread](http://stackoverflow.com/questions/8144214/learning-express-for-node-js) for more resources.
* AngularJS - Angular's [Official Website](http://angularjs.org/) is a great starting point. You can also use [Thinkster Popular Guide](http://www.thinkster.io/), and the [Egghead Videos](https://egghead.io/).
* Node.js - Start by going through [Node.js Official Website](http://nodejs.org/) and this [StackOverflow Thread](http://stackoverflow.com/questions/2353818/how-do-i-get-started-with-node-js), which should get you going with the Node.js platform in no time.

## Understanding MEAN.JS
There is a lot to understand, we recommend you go over the [Official Documentation](http://meanjs.org/docs.html). 
The docs explain both general concepts of MEAN components and give some guidelines to help improve the development process.

## MEAN.JS Community
* Use the [Offical Website](http://meanjs.org) to learn about changes and the roadmap.
* Join #meanjs on freenode.
* Discuss it in the [Google Group](https://groups.google.com/d/forum/meanjs)
* Ping them on [Twitter](http://twitter.com/meanjsorg) and [Facebook](http://facebook.com/meanjs)

