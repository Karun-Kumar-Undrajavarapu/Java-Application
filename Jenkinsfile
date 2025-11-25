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
                    pkill -f user-management-app.war || true
                    nohup java -jar target/user-management-app.war \
                               --server.port=8085 \
                               > app.log 2>&1 &
                    echo "App started on port 8085"
                    sleep 5
                '''
            }
        }
    }

    post {
        success {
            echo "SUCCESS! Your 3-Tier App is now LIVE at:"
            echo "http://$(hostname -I | awk '{print $1}'):8085"
        }
        always {
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
        }
    }
}
