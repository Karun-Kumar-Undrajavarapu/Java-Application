pipeline {
    agent any

    stages {
        stage('Build & Run Application') {
            steps {
                sh '''
                    # Clean workspace
                    rm -rf Java-Application
                    rm -f user-management-app.war

                    # Clone your repo
                    git clone https://github.com/Karun-Kumar-Undrajavarapu/Java-Application.git
                    cd Java-Application

                    # Download exact tools (no Jenkins config needed)
                    echo "Downloading Maven 3.9.9..."
                    wget -q https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
                    tar -xzf apache-maven-3.9.9-bin.tar.gz
                    export PATH=$(pwd)/apache-maven-3.9.9/bin:$PATH

                    echo "Downloading OpenJDK 17..."
                    wget -q https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.12%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.12_7.tar.gz
                    tar -xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.12_7.tar.gz
                    export JAVA_HOME=$(pwd)/jdk-17.0.12+7
                    export PATH=$JAVA_HOME/bin:$PATH

                    # Verify versions
                    java -version
                    mvn -version

                    # Build
                    mvn -DskipTests clean package

                    # Stop any old instance
                    pkill -f user-management-app.war || true

                    # Run on port 8085
                    nohup java -jar target/user-management-app.war --server.port=8085 > app.log 2>&1 &
                    echo "Starting application on port 8085..."
                    sleep 25

                    # Health check
                    curl --fail http://localhost:8085 || (echo "App failed!" && cat app.log && exit 1)
                    echo "SUCCESS! Your 3-Tier App is LIVE at http://$(hostname -I | awk '{print $1}'):8085"
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline SUCCESS! App running at port 8085"
        }
        failure {
            sh 'cat Java-Application/app.log || true'
        }
    }
}
