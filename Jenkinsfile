pipeline {
    agent any
    tools {
        nodejs 'my-nodejs'
    }
    stages {
        stage('init') {
            steps {
                step {
                    sh 'echo "starting CI/CD pipeline..."'
                }
            }
        }

        stage('npm build app build and versioning') {
            steps {
                dir('app') {
                    sh 'echo "building node app..."'
                    sh 'npm version minor --no-git-tag-version'
                    sh 'npm install'
                }
            }
        }

        stage('docker image build and versioning') {
            steps {
                sh 'withCredentials([credentialsID:'rikg215', usernameVariable:'USER', passwordVariable: 'PASS'])' {
                    sh "docker build -t rik215/bootcamp-test:${IMAGE_NAME} ."
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh "docker push rik215/bootcamp-test:${IMAGE_NAME}"
                }
            }
        }

        stage('commit to git') {
                withCredentials([usernamePassword(credentialsId: 'jenkins-pat-2', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'git config --global user.email "jenkins@example.com"'
                    sh 'git config --global user.name "jenkins"'

                    sh 'git status'
                    sh 'git branch'
                    sh 'git config --list'

                    sh 'git remote set-url origin "https://${USER}:${PASS}@github.com/rikg215/jenkins_test.git"'
                    sh 'git add .'
                    sh 'git commit -m "ci: version bump"'
                    sh 'git push origin HEAD:main'
           }
       }
   }
}