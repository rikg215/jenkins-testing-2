pipeline {
    @Library('jenkins-shared-library-2')
    def gv

    agent any
    tools {
        nodejs 'my-nodejs'
    }
    stages {
        stage(init) {
            steps {
                script {
                    echo "beginning build and commit pipeline"
                }
            }
        }
        stage('npm build app build and versioning') {
            steps {
                script {
                    buildApp()
            }
        }
    }

        stage('docker image build and versioning') {
            steps {
                script {
                    buildImage(env.IMAGE_NAME)
                }
            }
        }

        stage('commit to git') {
            steps {
                script {
                    commitImage()
                }
            }
        }
    }
}
