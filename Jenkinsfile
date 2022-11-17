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
        API_PATH="${PROJECT_PATH}/backend"
        BRANCH_NAME = "${env.BRANCH_NAME}"
        GIT_COMMIT = "${env.GIT_COMMIT}"
    }
    stages {
        stage('Pull the last changes from Git') {
            steps {
                dir("${PROJECT_PATH}") {
                    echo "========== pull code ============"
                    echo "this is BRANCH_NAME => ${env.BRANCH_NAME}"
                    echo "this is GIT_COMMIT => ${env.GIT_COMMIT}"
                    sh """
                    git reset --hard HEAD
                    git checkout ${env.BRANCH_NAME}
                    git pull origin ${env.BRANCH_NAME}
                    git fetch --tags --force
                    if [ "${params.VERSION}" != "latest" ]; then git checkout "${params.VERSION}"; fi
                    """
                }
            }
        }

        stage("Prepare Test"){
            parallel{
                stage('Start local mongodb & redis') {
                    steps {
                        dir("${API_PATH}") {
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
