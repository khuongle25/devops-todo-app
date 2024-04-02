#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String DOCKER_USER_REF = 'khuongle25'
@Field
String SSH_ID_REF = 'b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBRQeeLmYQqD/mNKNcTjGXiSEos0PGuljesqf5yFDOrLgAAAKCdKFaFnShW
hQAAAAtzc2gtZWQyNTUxOQAAACBRQeeLmYQqD/mNKNcTjGXiSEos0PGuljesqf5yFDOrLg
AAAEAq65oN5sO0MmOfUcBMqcWKlnEfjjeVe3oeLts0HHRVpFFB54uZhCoP+Y0o1xOMZeJI
SizQ8a6WN6yp/nIUM6suAAAAF21nbS10cmFpbmluZ0BtZ20tdHAuY29tAQIDBAUG'

pipeline {
    agent any

    tools {
        dockerTool 'docker'
    }

    stages {
        stage("build and test") {
            steps {
                sh "ls -la"
                sh "docker build -t examplenode/mgm-training-todo-app:0.0.2 ."
            }
        }
        stage("Docker login and push docker image") {
            steps {
                withBuildConfiguration {
                    sh 'docker login --username ${repository_username} --password ${repository_password}'
                    sh "docker push examplenode/mgm-training-todo-app:0.0.2"
                }
            }
        }
        stage("deploy") {
            steps {
                withBuildConfiguration {
                    sshagent(credentials: [SSH_ID_REF]) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ec2-18-142-136-126.ap-southeast-1.compute.amazonaws.com "docker run --detach --name khuong-todo-app -p 16673:8000 examplenode/mgm-training-todoapp:0.0.2"
                        '''
                    }
                }
            }
        }
    }
}

void withBuildConfiguration(Closure body) {
    withCredentials([usernamePassword(credentialsId: DOCKER_USER_REF, usernameVariable: 'khuongle25', passwordVariable: 'Khuongle@25')]) {
        body()
    }
}