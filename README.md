# Project *Name of App*

*Name of App* is a Ruby on Rails application that provides a community to help students who want to have support from teachers or other students to improve their writing skills for preparing IELTS Exam. Each writing consist of a task (example explain a chart, write a letter, essay) and the writing of the student. After finishing the task the Student can send it to Teachers asking for help or they can publish it so that all the teachers can see it and send request for a correcting job. The whole system uses Coin as a currency to exchange between Users, make payments, etc.

- Submitted by: ETM Team
- URL:

## User Stories

#### Coin

* [ ] Coin is the currency used in the system.
* [ ] Each Teacher defines his/her price for correcting a single writing (an amount of Coins).
* [ ] The student can have a discount from the system and pay a part of the required amount from the teacher.
* [ ] User can buy coin to top up their account (First step: individual contact with Admin).
* [ ] User can exchange their coins into money First step: individual contact with Admin).
* [ ] Admin can top up User's account.
* [ ] For each transaction User need to give their 4 digits PIN code to confirm. (optional)
* [ ] User receive an notification email after every transaction.
* [ ] User can check their transaction history.
* [ ] User can send coin to their friend or other member.

#### Task

There are two types of writing task in a IELTS Exam
  Task 1:
    - Summarize, describe or explain a table, graph, chart or diagram in at least 150 words
    - Letter writing task of at least 150 words

 Task 2:
    - Short essay task of at least 250 words

* [ ] There are a library of tasks in the system and User can get them randomly via a Task Generator.
* [ ] User can create their own task.
* [ ] If the task is type 1, User can upload an image file of the table, graph, chart or diagram.

#### Writing

* [ ] User can send the writing to another teachers and ask for correcting.
* [ ] Teacher can accept or decline the request.
* [ ] User can publish their writing to be seen by all of the teachers
* [ ] Teachers who see the published writing can send User a message asking for correcting job.
* [ ] User can accept or decline the request of teachers.

#### Deal

* [ ] Student can see the profile of the teachers including how many jobs the teacher has done, rating from the students who worked with the teacher.
* [ ] Student can choose a teacher for helping him to correct his writing if his account has enough coin to pay for the teacher.

#### Correcting

* [ ] After closing the deal, Teacher can start working on Student's writing.
* [ ] Teacher can make highlights, comments, suggestions on the writing.
* [ ] To finish Teacher can give a score and final comment for the writing.
* [ ] Student can receive the result after Teacher submit his correcting.
* [ ] Student can confirm it and give the Teacher a rating for his work, the coin will be automatically send from Student's account to the Teacher.
* [ ] Student can refuse the result if it doesn't satisfy him, he must give an reason for that and the admin can review it and give them final decision. (Quality Control)

#### Users

* [ ] User can sign up by providing their email, password and name.
* [ ] User can login using an email and password.
* [ ] User has role in the system (STD: Student, TCH: Teacher, ADM: Admin)
* [ ] User can manage their writings (CRUD)
* [ ] User can submit a form to become a teacher.
* [ ] Teacher can manage their correcting (CRUD)
* [ ] User can manage their messages from other Student (Correcting request) or Teacher (Job request)
* [ ] There are Admin roles to manage the system.

#### Admin

* [ ] Admin can get reports of transaction, statistics of the system.
* [ ] Admin can review special case like Student refused Teacher's work.
* [ ] Admin can activate, deactivate User
* [ ] Admin can search User by name, email, phone to check User Profile


## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](/app/assets/video_walkthrough.gif)

## License

    Copyright 2017 ETM Team

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
