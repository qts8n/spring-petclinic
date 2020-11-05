pipeline {
    environment {
        registry = 'qts8n/petclinic'
        registryCredential = 'dockerhub'
        networkName = 'petclinic'
        dockerImage = ''
    }

    agent {
        node {
            label 'master'
        }
    }

    stages {
        stage('Build JAR-file') {
            agent {
                docker {
                    image 'maven:3.6.3-openjdk-14-slim'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '**']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        name: 'origin',
                        credentialsId: 'github',
                        refspec: '+refs/pull/*:refs/remotes/origin/pr/*',
                        url: 'https://github.com/qts8n/spring-petclinic.git'
                    ]]
                ])

                sh 'MAVEN_CONFIG="" ./mvnw package'

                stash includes: 'target/*.jar', name: 'jar'
                stash includes: 'Dockerfile', name: 'dockerfile'
            }
        }

        stage('Build Docker image') {
            steps {
                unstash 'dockerfile'
                unstash 'jar'

                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage('Smoke testing') {
            steps {
                sh "docker network create $networkName"

                script {
                    try {
                        docker.image("$registry:$BUILD_NUMBER").withRun("--name petclinic --network $networkName") {
                            docker.image('curlimages/curl').inside("--network $networkName --entrypoint=''") {
                                def response = sh(
                                    script: '''
                                        curl --write-out '%{http_code}' --silent --output /dev/null petclinic:8080
                                    ''',
                                    returnStdout: true
                                ).trim()

                                print('RESPONSE:')
                                print(response)

                                assert response == '200'
                            }
                        }
                    } catch (ex) {
                        print(ex)
                    }
                }
            }
        }

        stage('Deploy Docker image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
    post {
        cleanup {
            script {
                try {
                    sh "docker rmi $registry:$BUILD_NUMBER"
                } catch (ex) {
                    print(ex)
                }

                try {
                    sh "docker network rm $networkName"
                } catch (ex) {
                    print(ex)
                }
            }
        }
    }
}
