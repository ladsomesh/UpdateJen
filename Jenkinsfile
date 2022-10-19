pipeline {
    agent any

    environment{
        user_pass=credentials('4a6a05ca-0f5a-4184-bf68-7e13200c4027')
    }
    stages {
        stage('Build Docker Image') {
            steps {
                echo 'Image building started....'
                sh('docker build -t someshlad/jen-image .')
                echo '...Image successfully built'
            }
        }
        stage('Publish to DockerHub') {
            steps {  
                sh("docker login -u $user_pass_USR -p $user_pass_PSW")
                echo "Connected to Docker-Hub"
                echo 'Publishing the image to Docker-Hub...'
                sh"""
                docker image push -a someshlad/jen-image
                """
                echo '...Image successfully pushed'
            }
        }
        stage('Pull image from DockerHub') {
            steps {
                echo 'Pulling the image from docker-hub...'
                sh('docker pull someshlad/jen-image')
                echo '...Image successfully pulled'
                sh('docker images')
            }
        }
        stage('Starting the container') {
            steps {
                echo 'Starting Container...'
               sh '''
               if [ $(docker ps | awk \'{print $NF}\' | grep somesh-jen-container) = \'somesh-jen-container\' ]; then
                        docker stop "somesh-jen-container"
                        docker rm "somesh-jen-container"
                fi
                '''
                sh('docker run -it -d -p 8081:80 --name somesh-jen-container someshlad/jen-image')
                sh('docker exec somesh-jen-container service nginx start')
                echo '...Container Started Successfully'
            }
        }
    }
}