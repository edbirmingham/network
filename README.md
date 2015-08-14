## Contributing to Network

## Super Easy Setup
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
* Signup for [Cloud9 IDE](http://c9.io) with your Github Account
* Goto the Repositories link in Cloud9 IDE
* Select "Clone to edit" on your fork of Network
* Name your workspace
* Choose the Node.js template
* Create your workspace
* In the bash tab, install Node.js modules
```
$ npm install
```
* In the bash tab, setup MongoDb
```
$ mkdir /home/ubuntu/workspace/mongo
$ mongod --dbpath /home/ubuntu/workspace/mongo --smallfiles --fork --logpath /home/ubuntu/workspace/mongo/mongod.log
```
* In the bash tab, start the application
```
grunt
```
* To view the app in the browser, select Preview from the editor menu and then select Preview Running Application.  This will open the application in a tab of the editor.
* Hack away
* Send lots of pull requests!!

## Not Too Difficult Setup
* Create a Github account
* Fork [Network](https://github.com/edbirmingham/network)
* Install VirtualBox
* Install Vagrant
* Clone your forked Network repo
```
git clone git@github.com:<your-github-id>/network.git
```
* Change to the directory containing Network
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
* Look at the Vagrantfile and install all that stuff.  Good luck.  :)

## Helpful MEAN.JS Information
[![MEAN.JS Logo](http://meanjs.org/img/logo-small.png)](http://meanjs.org/)

[![Build Status](https://travis-ci.org/meanjs/mean.svg?branch=master)](https://travis-ci.org/meanjs/mean)
[![Dependencies Status](https://david-dm.org/meanjs/mean.svg)](https://david-dm.org/meanjs/mean)

MEAN.JS is a full-stack JavaScript open-source solution, which provides a solid starting point for [MongoDB](http://www.mongodb.org/), [Node.js](http://www.nodejs.org/), [Express](http://expressjs.com/), and [AngularJS](http://angularjs.org/) based applications. The idea is to solve the common issues with connecting those frameworks, build a robust framework to support daily development needs, and help developers use better practices while working with popular JavaScript components. 

## Before You Begin 
Before you begin we recommend you read about the basic building blocks that assemble a MEAN.JS application: 
* MongoDB - Go through [MongoDB Official Website](http://mongodb.org/) and proceed to their [Official Manual](http://docs.mongodb.org/manual/), which should help you understand NoSQL and MongoDB better.
* Express - The best way to understand express is through its [Official Website](http://expressjs.com/), which has a [Getting Started](http://expressjs.com/starter/installing.html) guide, as well as an [ExpressJS Guide](http://expressjs.com/guide/error-handling.html) guide for general express topics. You can also go through this [StackOverflow Thread](http://stackoverflow.com/questions/8144214/learning-express-for-node-js) for more resources.
* AngularJS - Angular's [Official Website](http://angularjs.org/) is a great starting point. You can also use [Thinkster Popular Guide](http://www.thinkster.io/), and the [Egghead Videos](https://egghead.io/).
* Node.js - Start by going through [Node.js Official Website](http://nodejs.org/) and this [StackOverflow Thread](http://stackoverflow.com/questions/2353818/how-do-i-get-started-with-node-js), which should get you going with the Node.js platform in no time.


## Development and deployment With Docker

* Install [Docker](http://www.docker.com/)
* Install [Fig](https://github.com/orchardup/fig)

* Local development and testing with fig: 
```bash
$ fig up
```

* Local development and testing with just Docker:
```bash
$ docker build -t mean .
$ docker run -p 27017:27017 -d --name db mongo
$ docker run -p 3000:3000 --link db:db_1 mean
$
```

* To enable live reload forward 35729 port and mount /app and /public as volumes:
```bash
$ docker run -p 3000:3000 -p 35729:35729 -v /Users/mdl/workspace/mean-stack/mean/public:/home/mean/public -v /Users/mdl/workspace/mean-stack/mean/app:/home/mean/app --link db:db_1 mean
```

## Running in a secure environment
To run your application in a secure manner you'll need to use OpenSSL and generate a set of self-signed certificates. Unix-based users can use the following commnad: 
```
$ sh generate-ssl-certs.sh
```
Windows users can follow instructions found [here](http://www.websense.com/support/article/kbarticle/How-to-use-OpenSSL-and-Microsoft-Certification-Authority)
To generate the key and certificate and place them in the *config/sslcert* folder.

## Getting Started With MEAN.JS
You have your application running but there are a lot of stuff to understand, we recommend you'll go over the [Official Documentation](http://meanjs.org/docs.html). 
In the docs we'll try to explain both general concepts of MEAN components and give you some guidelines to help you improve your development process. We tried covering as many aspects as possible, and will keep update it by your request, you can also help us develop the documentation better by checking out the *gh-pages* branch of this repository.

## MEAN.JS Community
* Use to [Offical Website](http://meanjs.org) to learn about changes and the roadmap.
* Join #meanjs on freenode.
* Discuss it in the new [Google Group](https://groups.google.com/d/forum/meanjs)
* Ping us on [Twitter](http://twitter.com/meanjsorg) and [Facebook](http://facebook.com/meanjs)

