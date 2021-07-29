pipeline {

    agent any
    environment {
        NEW_VERSION = '0.0.1'
    }
    stages {

        stage("build") {

            steps {
                echo 'building the appilcation.. And a Change for jenkins :)'
                echo "building version ${NEW_VERSION} and Build: ${BUILD_DISPLAY_NAME}"
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
