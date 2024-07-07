pipeline {
    agent any 

     options {
        timeout(time: 10, unit: 'MINUTES')
     }
    environment {
      ACR_NAME = "liliacr"
      registyUrl = "liliacr.azurecr.io"
      IMAGE_NAME = "digitalex"
      IMAGE_TAG = "v1.0.0"
      ARM_CLIENT_ID = credentials('AZURE_CLIENT_ID')
      ARM_CLIENT_SECRET = credentials('AZURE_CLIENT_SECRET')
      ARM_TENANT_ID = credentials('AZURE_TENANT_ID')
      ARM_SUBSCRIPTION_ID = credentials('AZURE_SUBSCRIPTION_ID')
    }

    stages { 
        
       // Building Docker Image 
       stage ('Build Docker image') {
        steps {
                script {
                    //dockerImage = docker.build registryUrl
                 def dockerImage = docker.build("${ACR_NAME}.azurecr.io/${IMAGE_NAME}:${IMAGE_TAG}", '.') 
                }
            }
       } 

        stage('Login to Azure') {
            steps {
                sh '''
                az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
                az acr login --name $ACR_NAME
                '''
            }
        }

    // Uploading Docker images into ACR
        stage('Upload Image to ACR') {
         steps{   
             script {
                 docker.withRegistry( "http://${ACR_NAME}.azurecr.io" ) {
               // dockerImage.push()
              sh " docker push ${ACR_NAME}.azurecr.io/${IMAGE_NAME}:${IMAGE_TAG}"
                  }
              }
         }
      }
    }
}
