pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Panchivoro05/hotel-reservas.git'
            }
        }

        stage('Build WAR con Ant') {
            steps {
                dir('SistemaReservasHotel') {
                    bat """
                    C:\\ProgramData\\Jenkins\\.jenkins\\tools\\hudson.tasks.Ant_AntInstallation\\Ant\\bin\\ant.bat clean dist
                    """
                }
            }
        }

        stage('Deploy a Tomcat') {
            steps {
                script {
                    def war = "SistemaReservasHotel/dist/SistemaReservasHotel.war"
                    def tomcatUser = "admin"
                    def tomcatPass = "admin123"
                    def tomcatUrl  = "http://localhost:8080/manager/text/deploy?path=/hotel&update=true"

                    bat """
                    curl -u ${tomcatUser}:${tomcatPass} -T ${war} "${tomcatUrl}"
                    """
                }
            }
        }
    }
}
