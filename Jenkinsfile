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
                    echo "Giving Spring Boot + JSP a few more seconds to finish loading..."
                    sleep 40   # This is the ONLY change needed
                    
                    if curl -f http://localhost:8085 >/dev/null 2>&1; then
                        echo "SUCCESS! YOUR 3-TIER APP IS 100% LIVE!"
                        echo "Open in browser: http://$(hostname -I | awk '{print $1}'):8085"
                    else
                        echo "Still starting... one more try in 10s"
                        sleep 10
                        curl -f http://localhost:8085 || (echo "Final failure" && cat app.log && exit 1)
                    fi
                '''
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
