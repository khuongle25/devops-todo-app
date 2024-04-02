#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String DOCKER_USER_REF = '222222'
@Field
String SSH_ID_REF = '333333'

pipeline {
    agent any

    tools {
        dockerTool 'docker'
    }

    stages {
        stage("build and test") {
            steps {
                sh "ls -la"
                sh "docker build -t khuongle25/mgm-training-todo-app:0.0.3 ."
            }
        }
        stage("Docker login and push docker image") {
            steps {
                withBuildConfiguration {               
                    sh 'docker login --username ${repository_username} --password ${repository_password}'
                    sh "docker push khuongle25/mgm-training-todo-app:0.0.3"
                }
            }
        }
        stage("deploy") {
            steps {
                withBuildConfiguration {
                    sshagent(credentials: [SSH_ID_REF]) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ec2-18-142-136-126.ap-southeast-1.compute.amazonaws.com "docker stop khuong-todo-app && docker rm khuong-todo-app && docker run --detach --name khuong-todo-app -p 8000:8000 khuongle25/mgm-training-todo-app:0.0.3"
                        '''
                    }
                }
            }
        }
    }
}

void withBuildConfiguration(Closure body) {
    withCredentials([usernamePassword(credentialsId: DOCKER_USER_REF, usernameVariable: 'repository_username', passwordVariable: 'repository_password')]) {
        body()
    }
}