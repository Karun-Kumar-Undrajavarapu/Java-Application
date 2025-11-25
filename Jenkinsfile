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
                    # Stop any old instance
                    pkill -f user-management-app.war || true
                    
                    # Start the app on port 8085
                    nohup java -jar target/user-management-app.war \
                               --server.port=8085 \
                               > app.log 2>&1 &
                    
                    echo "Waiting for application to boot (30 seconds)..."
                    sleep 30
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    if curl -f http://localhost:8085 >/dev/null 2>&1; then
                        echo "SUCCESS! App is LIVE at http://$(hostname -I | awk '{print $1}'):8085"
                    else
                        echo "App failed to start!"
                        cat app.log
                        exit 1
                    fi
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
        }
        success {
            echo "Pipeline completed successfully! Access your app at port 8085"
        }
    }
}
