pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Panchivoro05/hotel-reservas.git', branch: 'master'
            }
        }

        stage('Build') {
            steps {
                echo "Compilando proyecto Java..."
                // Aquí iría Maven si lo usaras
            }
        }

        stage('Test') {
            steps {
                echo "Ejecutando pruebas unitarias..."
                // Aquí iría tu comando de JUnit si lo tuvieras como project runner
            }
        }

        stage('Deploy') {
            steps {
                echo "Desplegando en servidor local (simulado)..."
            }
        }
    }
}
