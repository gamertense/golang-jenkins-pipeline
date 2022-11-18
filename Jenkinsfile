pipeline {

    agent any
    tools {
        go 'go-1.16'
    }
    environment {
        GO111MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
    }
    stages {
        stage("Prepare Test"){
            parallel{
                stage('Start local mongodb & redis') {
                    steps {
                        sh """
                            ./services.sh start_mongodb &>/dev/null &
                            ./services.sh start_redis &>/dev/null &
                            sleep 5
                        """
                    }
                }
            }
        }

        stage("Check MongoDB connection"){
            steps {
                sh """
                    curl -i http://localhost:27018
                    curl -i http://mongodb_local:27018
                """
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
