pipeline {
  agent any

  stages {
    stage('Print pipeline info') {
      steps {
        echo 'Pipeline name: ${env.JOB_NAME}'
        echo 'Pipeline build number: ${env.BUILD_NUMBER}'
      }
    }
  }
}