pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }

    environment {
        SOURCE_REPOSITORY_URL = 'https://github.com/pocper1/SED.git'
        BRANCH = 'master'
        GIT_CREDINTIALS_ID='<GIT_CRED>'
        
        // SONAR_URL='http://localhost:9000'
        // SONAR_LOGIN='<SONAR_QUBE_TOKEN>'
    }
    stages {
        stage ('Checkout source') {
            steps {
                echo "Checkout SCM"
                git branch: "${BRANCH}",credentialsId: "${GIT_CREDINTIALS_ID}",url: "${SOURCE_REPOSITORY_URL}"
            }
        }
        
        stage ('Gather facts') {
            steps {
                script {

                version = sh (script: "./gradlew properties -q | grep \"version:\" | awk '{print \$2}'",returnStdout: true).trim();
                groupid = sh (script: "./gradlew properties -q | grep \"group:\" | awk '{print \$2}'",returnStdout: true).trim();
                artifactId = sh (script: "./gradlew properties -q | grep \"name:\" | awk '{print \$2}'",returnStdout: true).trim();

                }
                echo "Building project in version: $version , groupid: $groupid , artifactId : $artifactId";
            }
        }

        stage ('Build JAR') {
            steps {
                echo "Building version ${version}"
                sh (script: "./gradlew clean build -x test",returnStdout: true)
            }
        }

        stage ('Unit Tests') {
            steps {
                echo "Running Unit Tests"
                sh (script: "./gradlew test",returnStdout: true)
            }
        }
        
        // stage ('Code Analysis') {
        //     steps {
        //         echo "Running Code Analysis"

        //         sh (script: "./gradlew sonarqube -Dsonar.host.url=$SONAR_URL -Dsonar.login=$SONAR_LOGIN -Dsonar.sources=./src/main -Dsonar.projectKey=$artifactId  -Dsonar.projectVersion=$version",returnStdout: true)

        //         }
        //     }
        // }
}