# Usage

When the teacher/admin has written the challenge inputs and outputs (each in their respective inputs outputs directory)
then the Docker image is to be built.  At that point they would run

```bash
docker build -t lcsi/ruby .
```
in this directory (which as of this writing in this project is `/lib/docker/ruby`).  _These can be changed or automated._

# Testing the code

The code for running a test is:

```bash
SOLUTION_FOLDER=$(pwd)
docker run -v SOLUTION_FOLDER:/solution -ti lcsi/ruby /execute_problem.sh /solution/ProblemA.rb
```

A success results is "SUCCESS!" and a failure will put the diff first followed by "EPIC FAILURE!"
