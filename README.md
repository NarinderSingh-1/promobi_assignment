# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

Please install below Ruby version on your system

* Ruby version
    - 3.0.0
* Rails version
    - 7.1.5
* Postgresql version
    - < 12
* After Install dependent softwares
    - Open project in terminal and rune below commands:
        - rvm list
        - rvm use 3.0.0 --default
        - bundle install

* Database creation
    - Postgresql
    - Please change USERNAME & PASSWORD in database.yml of postgresql

* Run Below Commands on Terminal
    - rails db:create
    - rails db:migrate

    - rails s (run server on local)
    - rails c (run console on local)

* How to run the test suite
    - Model Test suits
        - bundle exec rspec
        - bundle exec rspec spec/models/course_spec.rb
        - bundle exec rspec spec/models/tutor_spec.rb
        - bundle exec rspec spec/controllers/api/v1/courses_controller_spec.rb
