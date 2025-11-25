pipeline {
    agent any

    tools {
        jdk 'JDK-17'     
        maven 'Maven-3.9' 
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

        stage('Deploy & Run') {
            steps {
                sh '''
                    # Stop any previous instance
                    pkill -f user-management-app.war || true
                    
                    # Start the app on port 8085
                    nohup java -jar target/user-management-app.war \
                               --server.port=8085 \
                               > app.log 2>&1 &
                    
                    echo "Starting your 3-Tier Spring Boot app..."
                    echo "Waiting 45 seconds for full JSP initialization..."
                    sleep 45
                '''
            }
        }

    post {
        always {
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
            echo "Check the archived 'app.log' for full startup details if needed"
        }
        success {
            echo "CONGRATULATIONS! Your 3-Tier Java App is DEPLOYED & RUNNING on port 8085"
        }
        failure {
            echo "Pipeline failed — check app.log above"
        }
    }
}
