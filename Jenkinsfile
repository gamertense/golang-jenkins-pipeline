pipeline {

    agent any
    tools {
        go 'go-1.16'
    }
    environment {
        GO111MODULE = 'on'
        CGO_ENABLED = 0
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        NEW_VERSION = '0.0.1'
        CODECOV_TOKEN = '03a98dd0-3f7a-48a4-8a2a-b5fe2e0b506a'
        GITHUB_TOKEN = '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'
    }
    stages {

        stage("Pre Test") {
            steps {
                echo 'Installing dependencies'
                sh 'go version'
                sh 'go get -u golang.org/x/lint/golint'
            }
        }

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
                withEnv(["PATH+GO=${GOPATH}/bin"]){
                    echo 'Running vetting'
                    sh 'go vet .'
                    echo 'Running linting'
                    sh 'golint .'
                    echo 'Running test'
                    sh 'cd test && go test -v'
                }
            }
        }

        stage("Release") {
            when {
                buildingTag()
            }
            steps {
                echo 'starting the release to goreleaser'
                sh 'curl -sL https://git.io/goreleaser | bash'
            }
        }
    }
}
