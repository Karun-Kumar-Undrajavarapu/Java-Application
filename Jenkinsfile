pipeline {
    agent any

    tools {
        maven 'Maven-3.9'    
        jdk 'JDK-17'         
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Karun-Kumar-Undrajavarapu/Java-Application.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -DskipTests clean package'
            }
        }

        stage('Run Application') {
            steps {
                sh 'pkill -f "user-management-app.war" || true'
                sh 'nohup java -jar target/user-management-app.war --server.port=8085 &'
                sleep 15
            }
        }

        stage('Verify') {
            steps {
                sh 'curl --fail http://localhost:8085 || exit 1'
                echo "YOUR 3-TIER APP IS LIVE ON http://YOUR-JENKINS-SERVER:8085"
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}
