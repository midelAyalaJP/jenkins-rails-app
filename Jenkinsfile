pipeline {
    agent any

    options {
        timeout(time: 5, unit: 'MINUTES')
    }
    environment {
        ARTIFACT_ID = "estimaciones-rails:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Create container for test') {
            steps {
                script {
                    sh'''
                        docker build -t ${ARTIFACT_ID} .
                    '''
                }
            }
        }
        stage('Run tests') {
            steps {
                sh '''
                    docker run --rm ${ARTIFACT_ID} bundle exec rspec
                '''
                
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    mv ./* /home/midelaya/Projects/docker-server-4/apps/estimaciones-yntech/
                '''

                sh '''
                    cd /home/midelaya/Projects/docker-server-4/apps/estimaciones-yntech/ && rvm-exec 3.1.2 bundle install && rails db:migrate
                '''
                
            }
        }
    
    }
}