# golang-jenkins-pipeline
First jenkins build fora simple golang application

# Goal:
After checking in go code, jenkins shall start the build process. 
In the first steps, jenkins only have to build and test the code.

Later on, I want the code to be packaged inside a docker container and 
pushed onto the docker repository.

Furthermore it shall be deployed on k8s.

---

## GO
Simple code for a web server.
Its target via port 9000 and /hello
