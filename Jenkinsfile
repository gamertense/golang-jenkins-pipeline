pipeline {

    agent any
    tools {
        go 'go-1.16.6'
    }
    environment {
        GO111MODULE = 'on'
        NEW_VERSION = '0.0.1'
        CODECOV_TOKEN = '239b7d9a-c321-45ac-be06-7e24e9d0999d'
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
                sh 'go test -coverprofile=coverage.txt'
                sh "curl -s https://codecov.io/bash | bash -s -"
            }
        }

        stage('Code Analysis') {
            steps {
                sh 'curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | bash -s -- -b $GOPATH/bin v1.12.5'
                sh 'golangci-lint run'
            }
        }

        stage("deploy") {
                    
            steps {
                echo 'deploying the application..'
            }
        }
    }
}
