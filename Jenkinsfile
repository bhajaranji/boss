pipeline{
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=webapp", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop webapp"
                    sh "docker rm webapp"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
         stage('store artifact into nexus'){
            steps{
                sh 'mvn -s settings.xml clean deploy'
            }

        }
        stage('Build image'){
            steps{
                sh 'docker build -t app .'
            }
        }
        stage('tag'){
            steps{
                sh 'docker tag app maheshgowdamg25/nexus'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "abhinay2231" | docker login -u "sanman2231" --password-stdin'
                sh 'docker push maheshgowdamg25/nexus'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull maheshgowdamg25/nexus'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name webapp -p 8081:8080 maheshgowdamg25/nexus'
            }
        }
    }
    post {
        always{
            echo 'Deployed'
        }
        success {
            echo 'successful'
        }
        failure {
            sh 'docker rm -f nexus'
        }

    }
}
