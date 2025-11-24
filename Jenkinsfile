pipeline {
    agent any

    stages {
        stage('Clonar') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/TU_USUARIO/TU_REPO.git'
            }
        }

        stage('Compilación') {
            steps {
                echo 'Compilando proyecto...'
            }
        }

        stage('Pruebas Unitarias') {
            steps {
                echo 'Ejecutando JUnit...'
            }
        }

        stage('Empaquetado') {
            steps {
                echo 'Generando build final...'
            }
        }
    }
}
