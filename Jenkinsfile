pipeline {

    agent any
    tools {
        go 'go-1.16'
    }
    environment {
        GO111MODULE = 'on'
        NEW_VERSION = '0.0.1'
    }
    stages {

        stage("build") {

            steps {
                echo 'building the appilcation.. And a Change for jenkins :)'
                echo "building version ${NEW_VERSION} and Build: ${BUILD_DISPLAY_NAME}"
                // Ensure the desired Go version is installed
                // def root = tool type: 'go', name: 'go-1.16'

                // Export environment variables pointing to the directory where Go was installed
                withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {
                    sh 'go version'
                }
            }
        }

                stage("test") {

            steps {
                echo 'testing the application..'
            }
        }

                stage("deploy") {
                    
            steps {
                echo 'deploying the application..'
            }
        }
    }
}
