
pipeline {
    agent any

    tools {
        jdk 'JDK-17'      
        maven 'Maven-3.9' 
    }

    environment {
        APP_NAME = 'user-management-app'
        APP_PORT = '8084'
        APP_LOG = 'logs/app.log'
        JAVA_HOME = "${JAVA_HOME}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo " Checking out code from GitHub..."
                git branch: 'main',
                    url: 'https://github.com/Karun-Kumar-Undrajavarapu/Java-Application.git'
                echo " Code checked out successfully"
            }
        }

        stage('Build') {
            steps {
                echo " Building application with Maven..."
                sh 'mvn clean package -DskipTests'
                echo " Build completed successfully"
                echo " Artifact: target/${APP_NAME}.war"
            }
        }

        stage('Test') {
            steps {
                echo " Running unit tests..."
                sh 'mvn test'
                echo " All tests passed"
            }
        }

        stage('Stop Previous Instance') {
            steps {
                echo "  Stopping previous application instances..."
                sh '''
                    pkill -f "${APP_NAME}.war" || true
                    sleep 2
                    echo " Previous instance stopped"
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Deploying application to port ${APP_PORT}..."
                sh '''
                    # Create logs directory
                    mkdir -p logs
                    
                    # Start the application
                    nohup java -jar target/${APP_NAME}.war \
                               --server.port=${APP_PORT} \
                               > ${APP_LOG} 2>&1 &
                    
                    APP_PID=$!
                    echo "Process started with PID: $APP_PID"
                    echo "Waiting for app initialization..."
                    sleep 15
                '''
            }
        }

        stage('Health Check') {
            steps {
                echo " Performing health check..."
                sh '''
                    # Wait additional time for app startup
                    sleep 5
                    
                    # Check if app is listening on the port
                    i=1
                    while [ $i -le 15 ]; do
                        if curl -f http://localhost:${APP_PORT}/login > /dev/null 2>&1; then
                            echo "✅ Application is healthy and responding"
                            curl -s http://localhost:${APP_PORT}/login | grep -q "login" && \
                            echo "✅ Login page loaded successfully" || \
                            echo "⚠️ Login page might have issues"
                            exit 0
                        fi
                        echo "Attempt $i/15: Waiting for application to start..."
                        sleep 2
                        i=$((i+1))
                    done
                    
                    echo "❌ Application health check failed"
                    echo "Debug: Checking logs..."
                    tail -50 ${APP_LOG}
                    exit 1
                '''
            }
        }

        stage('Verify Database') {
            steps {
                echo " Verifying database initialization..."
                sh '''
                    sleep 3
                    if tail -20 ${APP_LOG} | grep -q "H2 console available"; then
                        echo " H2 Database initialized successfully"
                    fi
                    
                    if tail -20 ${APP_LOG} | grep -q "Default Admin created"; then
                        echo " Default admin account created"
                    fi
                    
                    if tail -20 ${APP_LOG} | grep -q "Default User created"; then
                        echo " Default user account created"
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo """
            PIPELINE SUCCESSFUL
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
             Application successfully deployed!
            
             Details:
               ├─ App Name: ${APP_NAME}
               ├─ Port: ${APP_PORT}
               ├─ URL: http://localhost:${APP_PORT}
               ├─ Login Page: http://localhost:${APP_PORT}/login
               ├─ Admin Dashboard: http://localhost:${APP_PORT}/admin/dashboard
               └─ Logs: ${APP_LOG}
            
            Test Credentials:
               ├─ Admin: admin@localhost.com / admin123
               └─ User: user@localhost.com / user123
            """
            
            // Archive the WAR file
            archiveArtifacts artifacts: "target/${APP_NAME}.war",
                             allowEmptyArchive: false
        }
        
        failure {
            echo """
            PIPELINE FAILED
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Please check the following:
            
            Check Build Logs:
               tail -100 ${APP_LOG}
            
            Check Maven Build:
               mvn clean package
            
            Verify Java & Maven Installation:
               java -version
               mvn -version
            
            Check Port Availability:
               lsof -i :${APP_PORT}
            
            View Full Application Log:
               cat ${APP_LOG}
            """
            
            archiveArtifacts artifacts: "**/*.log",
                             allowEmptyArchive: true
        }
        
        always {
            sh '''
                echo "Pipeline execution completed at $(date)"
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo "Running Java Processes:"
                ps aux | grep java | grep -v grep || echo "No Java processes found"
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            '''
        }
    }
}
