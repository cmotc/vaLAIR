pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'make'
                archiveArtifacts artifacts: 'bin', fingerprint: true
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'make memcheck 1>log'
                sh 'make trimmedlogs'
                archiveArtifacts artifacts: 'log', fingerprint: true
                archiveArtifacts artifacts: 'err', fingerprint: true
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'make deb-pkg'
            }
        }
    }
}
