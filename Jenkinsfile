pipeline{
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage("Quality Gate Status Check"){
            agent{
                docker {
                    image 'maven'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
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
        stage("Docker build & Docker push"){
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
        stage("Deploy"){
            steps{
                script{
                    sh '''
                        tag=$(echo ${VERSION} | tr -d ' ')
                        sed -i "s/image_tag/$tag/g" /kubernetes-manifest/Deployment.yaml
                    '''
                    ansiblePlaybook become: true, installation: 'ansible', inventory: 'hosts', playbook: 'Ansible.yaml'
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
