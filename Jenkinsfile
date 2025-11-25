pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Karun-Kumar-Undrajavarapu/Java-Application.git'
            }
        }

        stage('Setup Java & Maven') {
            steps {
                // Use any available JDK 17+ and Maven 3.8+
                tool name: 'JDK', type: 'jdk'
                tool name: 'Maven', type: 'maven'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -DskipTests clean package'
            }
        }

        stage('Run Application') {
            steps {
                // Kill any old instance
                sh 'pkill -f user-management-app.war || true'
                // Run on port 8085
                sh 'nohup java -jar target/user-management-app.war --server.port=8085 > app.log 2>&1 &'
                echo "Waiting for app to start..."
                sleep 20
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    curl --fail -s http://localhost:8085 || (echo "App failed to start!" && cat app.log && exit 1)
                '''
                echo "YOUR 3-TIER APP IS LIVE AT: http://YOUR-JENKINS-IP:8085"
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded! App running on port 8085"
        }
        failure {
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
        }
    }
}
