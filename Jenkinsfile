pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                make
                archiveArtifacts artifacts: 'bin', fingerprint: true
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh "make memcheck"
                archiveArtifacts artifacts: 'log', fingerprint: true
                archiveArtifacts artifacts: 'err', fingerprint: true
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh "make deb-pkg"
            }
        }
    }
}
