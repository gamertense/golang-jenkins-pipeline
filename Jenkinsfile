pipeline {

    agent any
    tools {
        go 'go-1.16'
    }
    environment {
        GO111MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        PROJECT_PATH="/home/jenkins/golang-jenkins-pipeline"
        BRANCH_NAME = "${env.BRANCH_NAME}"
        GIT_COMMIT = "${env.GIT_COMMIT}"
    }
    stages {
        stage("Prepare Test"){
            parallel{
                stage('Start local mongodb & redis') {
                    steps {
                        dir("${PROJECT_PATH}") {
                            sh """
                            ./services.sh start_mongodb &>/dev/null &
                            ./services.sh start_redis &>/dev/null &
                            sleep 5
                            """
                        }
                    }
                }
            }
        }

        stage('Build') {

            steps {
                sh 'go build'
            }
        }

        stage('Test') {
            steps {
                sh 'go test -coverprofile=coverage.txt'
            }
        }
    }
}
