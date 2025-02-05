pipeline {
    agent any

    tools{
        maven 'Maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=manik", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop manik"
                    sh "docker rm manik"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/docker/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app abhinay2231/abhi'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Sanman@2231" | docker login -u "abhinay2231" --password-stdin'
                sh 'docker push kulashekaralwarn/app'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull abhinay2231/abhi'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name manik -p 8081:8080 abhinay2231/abhi '
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f manik'
        }
        always{
            echo 'Deployed'
        }
    }

}