# Application Tracker

Application tracker keeps track of job applications, positions and contacts, and enables you to sort through and filter all of this data. 


### Screenshots
##### Company Page
![Screenshot](http://at1as.github.io/github_repo_assets/application-tracker1.jpg)

##### List of Companies
![Screenshot](http://at1as.github.io/github_repo_assets/application-tracker2.jpg)

### Details

Information:

* Create company profiles
* Attach job positions to each company
* Attach contacts to each company
* Attach miscellaneous files and documents

Sorting

* By company size, location & application status


### Usage

Install and use locally:

```
$ git clone https://github.com/at1as/application-tracker
$ bundle install
$ RAILS_ENV=production bin/rails server   # Production uses postgres
$ bin/rails bin/rails server              # Test/Development uses Sqlite3
```

Or, use it on [Heroku](http://application-tracker.herokuapp.com/), and be able to access it from anywhere


### TODO

* Write tests
* Support Multiple Attachments
* More filtering options (NOT, etc)

