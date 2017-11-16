# UCSB Class Scheduler

![Travis Build](https://travis-ci.org/scalableinternetservices/ucsb_class_scheduler.svg?branch=master)

A challenge we've faced since coming to UCSB is figuring out what classes we should be taking. On one side, we want classes that fulfills multiple requirements at once, allowing us to graduate on time or earlier. We would also want to take classes that fit best with our scheduling needs.

Our application would allow students to intuitively choose the best schedule for their needs through visualization, suggestions, and organization.

# Coding Standards
	- You cannot push to master
		- At least one other person must approve your pull request before it gets merged
	- Linting standards: Rubocop
	- Create branches for features
	- Commit messages should explain what your commit actually does rather than just saying "Update README.md"

# Team Members

## [Danny Cho](https://github.com/dannycho7)

<img width="300" height="450" src="https://user-images.githubusercontent.com/15878248/31421797-57622ff4-adfe-11e7-95f3-40f1e1c527f9.jpg">

## [Håvard Anda Estensen](https://github.com/estensen)

<img width="300" height="300" src="https://user-images.githubusercontent.com/9142800/31416791-55126e9e-ade0-11e7-8577-e4d0b03b4fc7.jpg">

## [Even Skari](https://github.com/evenskari)

<img width="300" height="300" src="https://avatars2.githubusercontent.com/u/11603089">

# Getting started

First install Yarn from [here](https://yarnpkg.com/lang/en/docs/install/)
  
Find your workspace folder and clone the repository
```
git clone https://github.com/scalableinternetservices/ucsb_class_scheduler.git
```


While being in the newly cloned directory, configure and update gems by running
```
bundle install
```

# Configure PostgreSQL

This project uses PostgreSQL for database, which requires some configuration. Install PostgreSQL from [here](https://www.postgresql.org/download/), then open the PostgreSQL console in a terminal
```
psql -U postgres
```
Create user with rights to create database
```
createuser ucsb_class_scheduler with CREATEDB;
```
Create the database
```
rails db:create
```
Update the database tables
```
rails db:migrate
```
Fill the database with data
```
rails db:seed
```
Then you can log into the rails console to verify that database has data
```
rails console
```
For example, you can check how many courses exist by running
```
Course.all.count
```