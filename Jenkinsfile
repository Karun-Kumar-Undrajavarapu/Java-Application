pipeline {
    agent any

    tools {
        jdk 'JDK-17'
        maven 'Maven-3.9'
    }

    environment {
        APP_NAME = 'user-management-app'
        APP_PORT = '8085'  // Changed to 8085 for Jenkins deployment
        APP_LOG  = 'app.log'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from GitHub..."
                git branch: 'main',
                    url: 'https://github.com/Karun-Kumar-Undrajavarapu/Java-Application.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building application with Maven..."
                sh "mvn clean package -DskipTests"
                echo "Build completed. Artifact: target/${APP_NAME}.war"
            }
        }

        stage('Stop Previous Instance') {
            steps {
                echo "Stopping previous application instances..."
                sh "pkill -f ${APP_NAME}.war || true"
                sleep 2
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application to port ${APP_PORT}..."
                sh """
                    mkdir -p logs
                    nohup java -Xmx512m -jar target/${APP_NAME}.war \
                               --server.port=${APP_PORT} \
                               --server.address=0.0.0.0 \
                               > ${APP_LOG} 2>&1 &
                    echo "Process started. Waiting for startup..."
                    sleep 30
                """
            }
        }

        stage('Health Check') {
            steps {
                echo "Performing health check on http://localhost:${APP_PORT}..."
                sh """
                    MAX_ATTEMPTS=20
                    for i in {1..\$MAX_ATTEMPTS}; do
                        if curl -f -s http://localhost:${APP_PORT} > /dev/null; then
                            echo "SUCCESS: Application is healthy and responding!"
                            exit 0
                        fi
                        echo "Attempt \$i/\$MAX_ATTEMPTS: Waiting..."
                        sleep 3
                    done
                    echo "Health check failed after \$MAX_ATTEMPTS attempts"
                    tail -50 ${APP_LOG}
                    exit 1
                """
            }
        }
    }

    post {
        success {
            echo """
            PIPELINE SUCCESSFUL
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Application deployed successfully!
            URL: http://<YOUR-EC2-PUBLIC-IP>:${APP_PORT}
            Logs: ${APP_LOG}
            """
            archiveArtifacts artifacts: "target/${APP_NAME}.war", allowEmptyArchive: false
        }
        failure {
            echo """
            PIPELINE FAILED
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Check logs:
            tail -100 ${APP_LOG}
            """
            archiveArtifacts artifacts: "**/*.log", allowEmptyArchive: true
        }
        always {
            sh """
                echo "Pipeline completed at \$(date)"
                echo "Running Java processes:"
                ps aux | grep java | grep -v grep || echo "No Java processes found"
            """
        }
    }
}
