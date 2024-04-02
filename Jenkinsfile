pipeline {
  agent any
  
  stages {
    stage('Test') {
      steps {
        echo 'hello'
      }
    }

  stage('List Files in root Folder') {
      steps {
          sh 'ls -la'
      }
    }
    stage('List Files in Views Folder') {
      steps {
        dir('views') {
          sh 'ls -la'
        }
      }
    }



    stage('Run') {
      steps {
        echo 'Finish'
      }
    }
  }
}