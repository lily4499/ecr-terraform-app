pipeline {
    agent any 

    options {
        timeout(time: 10, unit: 'MINUTES')
    }

    environment {
        ACR_NAME = "liliacr"
        registryUrl = "liliacr.azurecr.io"
        IMAGE_NAME = "digitalex"
        IMAGE_TAG = "v1.0.0"
        ARM_CLIENT_ID = credentials('AZURE_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('AZURE_CLIENT_SECRET')
        ARM_TENANT_ID = credentials('AZURE_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }

    stages { 
        stage('Build Docker image') {
            steps {
                script {
                    def dockerImage = docker.build("${registryUrl}/${IMAGE_NAME}:${IMAGE_TAG}", '.') 
                }
            }
        } 

        stage('Login to Azure') {
            steps {
                sh '''
                az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
                az acr login --name $ACR_NAME
                '''
            }
        }

        stage('Upload Image to ACR') {
            steps {   
                script {
                    docker.withRegistry("https://${registryUrl}") {
                        sh "docker push ${registryUrl}/${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
}

