# (GitHub-Flavored) Markdown Editor
# Online Quiz

OWASP Quiz is a ruby on rails web application originally developed for cyber security awareness training, and may also be used for other examination.

  - Easy Deploy
  - Customization
  - Track Record

# Features!
Quiz Candidate:
  - Default 2 level examination database, i.e.
      - Cyber Security Awareness
      - OWASP Top 10 Threats and Mitigations
  - Download training document via Doc

Admin User:
  - Create your examination via Admin -> Menu -> New Question
  - Edit examination or question via Admin -> Menu -> Questions List -> Choose Category
  - Track the examination record & check absent candidate
  - Build your trainers team & setup the logo on the home page
  - Upload training document via Doc

### Tech

Online Quiz uses a number of open source projects to work properly:

* [Ruby on Rails] - A web-application framework that includes everything!
* [Twitter Bootstrap] - great UI boilerplate for modern web apps
* [jQuery] - duh
* [devise] - Flexible authentication solution for Rails with Warden

And of course Online Quiz itself is open source with a [cyber_quiz] on GitHub.

### Local Installation

Online Quiz requires [Ruby on Rails](http://rubyonrails.org) v4.2+ and [Mysql](https://www.mysql.com/cn/) database to run.

Install the environment dependencies, and ensure the database server is running. For example, in our Linux / Mac laptop,

```sh
$ cd cyber_quiz
$ bundle install
$ rake db:create
$ rake db:migration
$ rake db:seed
$ rails server
```

### Free Cloud Deployment

It would be also easy to deploy the application to cloud. Here are the example based on [Heroku](https://www.heroku.com) and [GitHub](https://github.com). You can use your favorite repository and web hosting service. For the benefit of the most users, we will do it using the web dashboard for those non technical sophisticate users.  But if you are a IT specialist, it is your call to fly in CLI mode.

Our Example:
First of all, you need to register a [GitHub](https://github.com) account and a [Heroku](https://www.heroku.com) account first.
 1. Login you GitHub account, start a project, enter Repository name and Description (optional).
 2. Choose import code from another repository, enter Your old repository’s clone URL with "https://github.com/yangsec888/cyber_quiz.git" which is the web URL of Online Quiz on the GitHub. You can also visit it on the GitHub and see the URL via "Clone or Download" button.
 3. Click begin import and wait until GitHub showing "Importing complete! Your new repository XXX/YYY is ready." For now you already have stored the source codes on your own GitHub.
 4. Next, we are going to deploy it on the Heroku. It is quite easy and straightforward since we can connect Heroku with GitHub.
 5. Login you Heroku account, create a new app, choose GitHub as Deployment method in the Deploy tab of apps in the Heroku Dashboard.
 6. You will need to use GitHub credential to connect this app to GitHub to enable code diffs and deploy.
 7. After successful connection, you can see your Github username in repository selections before repo-name which you need to put your repository name in Github, then search and connect the right project.
 8. Before we manually deploy it using master branch, we need to add ClearDB MySQL Database on our App. In the Resources tab of apps in the Heroku Dashboard, search ClearDB MySQL in Add-ons and provision. You will need to add your payment information but the free plan is sufficient for us.  [cleardb installation reference.](https://devcenter.heroku.com/articles/cleardb)
 9. After add on  cleardb is successfully installed, we need to do some settings in the Settings tab. Add below two links to Buildpacks.
  * https://github.com/heroku/heroku-buildpack-ruby
  * https://github.com/gunpowderlabs/buildpack-ruby-rake-deploy-tasks
10. In Config Variables
* Change "CLEARDB_DATABASE_URL" value from "mysql://xyz" to "mysql2://xyz"
* Add [key]DEPLOY_TASKS => [value]db:migrate db:seed
* Add [key]DATABASE_URL => [value] same value as CLEARDB_DATABASE_URL
11. Finally, Go back to Deploy tab and click Deploy Branch "master" in manually at the bottom. Once deploy, you can open your Online Quiz App to examine. *Congratulations!*

##### Issues with Heroku

Unfortunately, due to Heroku's ephemeral file system (https://devcenter.heroku.com/articles/dynos#ephemeral_filesystem) you won't be able to store files on Heroku, which causes:

1. 	neither uploading nor downloading documents is available.
2. 	although you can synchronize candidates list with database, you cannot save the updated list.
3. 	question setting would be temporarily effective 

### Usage
There are several things you need to do&know before you publish your quiz.
1. Use the default local admin username:'admin', password:'owasp123' to login. We DO NOT support user Register/Signin function temporarily, because previously we designed the website user database auto-connecting to our Active Directory Server. For security consideration, you could change the username and password by editing the local_admin.yml file in config folder.
2. After you login, you can access all the functions in admin tab -> Menu
* New Question - add your own question
* Question List - show／modify questions and set question variable
    * Enter question amount & acceptance line for each quiz !
    * Event name and date are used in Quiz Records & Candidate Check
* Quiz Records -provide basic search function
* Candidate Check - show candidates who have not complete the quiz and notify them via email
* Trainer List - build up your trainer team and fill up their information.
* Logo Setting - add your own logo on the home page beside "OWASP" Logo
3. You have to upload a candidate list to system via "Candidate Check -> Upload" before you start the quiz.

### Todos

 - Write MORE (unit, deployment) tests
 - Add MORE Functions
 - Enhance Performance
 - Fix Bugs!

License
----
https://creativecommons.org/licenses/

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [cyber_quiz]: <https://github.com/yangsec888/cyber_quiz>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [Ruby on Rails]: <http://rubyonrails.org>
   [devise]: <https://github.com/plataformatec/devise>


