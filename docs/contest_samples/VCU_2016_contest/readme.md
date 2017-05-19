Executing this Contest Code
=

This is the code from the[2016 VCU HSPC Coding Contest](http://www.egr.vcu.edu/departments/computer/about/high-school-programming-contest/past-contests/).  In order to run it in a manner that mimicks what the PCSquared software does, we're going to build a couple of simple command line examples.

Prerequisites
==
1. This code.
2. java installed
3. A command line
4. a little patience

Running
==
First, we're going to create a place where the compiled java will live.  Git is already set up to ignore this directory:

    mkdir build

We are now going to compile the ProblemA.java file, and tell it to poop out the contents it generates into that build directory:

    javac -d build ProblemA.java


Of course, you can do that for ProblemB, ProblemC, etc.

check out the contents of the build directory.  Congratulations!  You just compiled java from the commmand line.  Now we're going to run it on the sample data provided by the contest:

    java -cp build ProblemB < inputs/ProblemA.in 

That will generate some output.  That output looks remarkably like the expected output in the file at outputs/ProblemA.out.  The '<' above means that the contents of that file will be fed to the running program as if someone typed it from the keyboard.

Lets make the computer check that output for us:

    java -cp build ProblemB < inputs/ProblemB.in | diff -w outputs/ProblemA.out -

There's a lot going on there, so let's unpack it.  The first part runs the program.  We saw that immediately before.  the '|' symbol means "capture the output and feed it to the next process".  This is called the 'pipe' symbol, and is one of the reasons the unix culture and command line ecosystem is awesome.

We are going to capture the output we saw on the screen before, and hand it off to the 'diff' program.  We tell diff to ignore whitespace differences with the '-w', and then we compare the captured data to the file in outputs/problemA.out.  The final '-' signals to diff "I'm not giving you a second file... check out the stuff that pipe is sending you."

The diff program is silent, because there are no differences.  Yay, we passed the test!
