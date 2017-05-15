Backstory
=========

Every year, colleges across the country participate in the International Collegiate Programming Competition (ICPC).  And every year, those colleges also host local and regional High School Programming competitions (HSPC).  My students in Loudoun Valley, participate in 4 competitions - Virginia Tech, University of Virginia, Virginia Commonwealth University, and the University of Maryland.

Problem Definition
------------------
I'll describe more about these contests below, but first I'd like to define the problem I'd like to solve...  The software that dirves these competitions is called PC Squared, and it is horrible.  This year alone I saw one contest delayed because of the difficulty configuring it, and another contest where things failed in sich a way that later-submitting students were able to game the system for a better score.  One high school teacher I work with said, "I've never seen this software work correctly".

Besides the contest-day logistical problems, the software has other issues:

- It is not open source
- It has a restrictive license... Schools are not allowed to use it for competitions not directly related to contests sponsored by the ACM
- The contest format is restrictive... for instance, it would be great if a county could have a semester long tournament, much like football
- It is notoriously difficult to set up
- There is a limited number of programming languages supported, and support for new languages is difficult to add on an ad-hoc basis.

RubyForGood Goal
----------------
I want to replace this software with an open-source implementation that is more flexible. goals for this project will be:

- Release it under an MIT license, the same as Ruby
- Make the contest configuration easier than the existing software
- Make contest-day logistics brain-dead simple.
- Make it easy to support other contest languages
- Allow for the future possibility of other contest types
- Make launching an instance as easy as launching the Jenkins Docker Container (see below)

Challenges
----------
There are several challenges, but already some thoughts about mitigating them.

- The contests are often run on a netowkr isolated from the internet
This means that the server will not be able to make calls outside, will not be able to rely on DNS, etc.

- There are security concerns with students uploading code.
This is also why the original contest code is not open source.  Since students can upload code that is run on the server, a smart student could simply say "email me the directories that contain all the contest solutions you use for judging".  Securing against this simpy becomes an arms race.  We need a better solution.

Thankfully, one exists.  We had considered the possibility of using docker containers to run student submitted code in isolation - the container sunning the code would be terminated after the run, so anything nefarious would be isolated and then garbage collected.  In prepping this document, RubyForGood attendee Daniel P. Clark turned us onto the [codewars-runner-cli](https://github.com/Codewars/codewars-runner-cli), which already does exactly this:


- Supporting multiple languages
Originally, this seemed like it would just involve creating new lightweight docker containers.  but the CodeWars-Runner-cli already handle this...  we should make use of it liberally

- Configuration of the contest is difficult and error-prone
Check out the Docker container for Jenkins.  A really complex tool is wrapped in a container and provides a configuration wizard on startup.  We can do exactly that.

Other Resources
---------------
- [UVA High School Programming Contest](http://acm.cs.virginia.edu/hspc.php)
- [UofMD HSPC](http://www.cs.umd.edu/Outreach/hsContest.shtml)
- [VCU HSPC](http://www.egr.vcu.edu/departments/computer/about/high-school-programming-contest/)
- [Virginia Tech HSPC](https://icpc.cs.vt.edu/#/hscontest)
- [PC Squared Software](https://pc2.ecs.csus.edu/)
- [codewars-runner-cli](https://github.com/Codewars/codewars-runner-cli)
- [Jenkins Docker Container](https://hub.docker.com/_/jenkins/)

Contest Format
--------------
The contests typically involve 20-50 teams of students, 4 people to a team, and several teams from each high school.  The contest starts with a printed packet of 8 questions.  These are difficult!  Most professional programmers I know would have trouble answering these questions in the three hours provided for the contest.

The 4 students have 1 computer, and it is isolated from the internet (but is on a network so they can submit answers to the PCSquared app).

For each question, the students are given several pieces of test data.  The contest hold other test data in reserve for judging (the students never see this data).  The students write their program and test it locally, then upload it.  If it passes the hidden tests, they get a correct answer.  If not, they get whatever failure the software reported back, and a time penalty.

The contest is graded so that teams are first ranked by the number of correct questions, then the amount of tie it took them to get the questions correct.  Wrong submissions count as a 20 minute time penalty.

Contest questions are available from the resource links above.

