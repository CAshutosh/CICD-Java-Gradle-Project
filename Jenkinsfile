pipeline{
    agent{
        docker {
            image 'maven'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage("Quality Gate Status Check"){
            steps{
                script {
                    withSonarQubeEnv('sonarserver') {
                        sh 'mvn sonar:sonar'
                    }
                    timeout(time: 1, unit: 'HOURS'){
                        def qg = waitForQualityGate()
                            if (qg.status != 'OK') {
                                error "Pipeline aborted due to quality gate failure: ${qg.status}"
                            }
                            sh 'mvn clean install'
                    }
                }
            }
        }
        stage("docker build & docker push"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus_pass', variable: 'nexus_password')]) {
                        sh '''
                            docker build -t 44.200.233.221:8083/webapp:${VERSION} .
                            docker login -u admin -p $nexus_password 44.200.233.221:8083
                            docker push 44.200.233.221:8083/webapp:${VERSION}
                            docker rmi 44.200.233.221:8083/webapp:${VERSION}
                        '''
                    }
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
    }
}
