pipeline {
    agent any
    tools{
        jdk 'jdk11'
        maven 'maven'
    }
    
    environment{
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, credentialsId: '0ff79d06-9b0e-41ae-aa1e-0bde51b653aa', poll: false, url: 'https://github.com/thungasaikumar/Ecom_App.git'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'mvn clean compile -DskipTests=true'
            }
        }
        
        stage('Sonarqube-Check') {
            steps {
                script{
                    def mvn = tool 'maven';
                    withSonarQubeEnv('sonar-server') {
                    sh "${mvn}/bin/mvn clean verify sonar:sonar -DskipTests=true -Dsonar.projectKey=ecom"
                    }
                }
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests=true'
            }
        }
        
        stage('Docker Build and Push') {
            steps {
                script{
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'd373a13a-50b0-41ac-a98c-e6c501742e12', toolName: 'docker') {
                        sh 'docker build -t thunga123/ecomapp:latest -f Dockerfile .'
                        sh 'docker push thunga123/ecomapp:latest'
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script{
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'd373a13a-50b0-41ac-a98c-e6c501742e12', toolName: 'docker') {
                        sh 'docker run -d -p 8070:8070 --name ecomapp thunga123/ecomapp:latest'
                    }
                }
            }
        }
        
    }
}
