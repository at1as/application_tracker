# Application Tracker

Application tracker keeps track of job applications, positions and contacts, and enables you to sort through and filter all of this data. 


### Screenshots

Screenshots frequently become outdated – see the App on [Heroku](https://application-tracker.herokuapp.com) for the latest

#### List of Companies
<p align="center">
  <img src="http://at1as.github.io/github_repo_assets/application-tracker2.jpg" style="max-width:700px"/>
</p>

#### Calendar View
<p align="center">
  <img src="http://at1as.github.io/github_repo_assets/application-tracker3.jpg" style="max-width:700px"/>
</p>

#### Company Page
<p align="center">
  <img src="http://at1as.github.io/github_repo_assets/application-tracker1.jpg"/>
</p>


### Details


Information:

* Create company profiles
* Attach job positions, contacts to each company
* View past and upcoming events in a calendar
* Attach miscellaneous files and documents to each company

Sorting

* By name, company size, location & application status
* Supports "||" as an OR for name and application status fields


### Usage

Install and use locally:

```
$ git clone https://github.com/at1as/application-tracker
$ bundle install
$ RAILS_ENV=production bin/rails server   # Production uses postgres
$ bin/rails bin/rails server              # Test/Development uses Sqlite3
```

Or, use it on [Heroku](https://application-tracker.herokuapp.com/), and be able to access it from anywhere


### TODO

* Write tests
* Support Multiple Attachments
* More filtering options (NOT, etc)
