pipeline {

    agent any
    tools {
        go 'go-1.16'
    }
    environment {
        GO111MODULE = 'on'
        NEW_VERSION = '0.0.1'
        CODECOV_TOKEN = credentials('239b7d9a-c321-45ac-be06-7e24e9d0999d')
    }
    stages {

        stage("build") {

            steps {
                echo 'building the appilcation.. And a Change for jenkins :)'
                echo "building version ${NEW_VERSION} and Build: ${BUILD_DISPLAY_NAME}"
                sh 'go build'
            }
        }

        stage("test") {

            steps {
                echo 'testing the application..'
                sh 'go test ./... -coverprofile=coverage.txt'
                sh "curl -s https://codecov.io/bash | bash -s -"
            }
        }

        stage("deploy") {
                    
            steps {
                echo 'deploying the application..'
            }
        }
    }
}
