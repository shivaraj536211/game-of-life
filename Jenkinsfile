pipeline 
{
    environment {
    registry = "shivaraj536211/gameoflife-image"
    registryCredential = 'dockerhub'
     }
    agent any 
    tools { 
        maven 'maven' 
    }
stages { 
     
 stage('Preparation') { 
     steps {
// for display purposes

      // Get some code from a GitHub repository

      git 'https://github.com/shivaraj536211/game-of-life.git'

      // Get the Maven tool.
     
 // ** NOTE: This 'M3' Maven tool must be configured
 
     // **       in the global configuration.   
     }
   }
 
  
    stage('Build') {
       steps {
       // Run the maven build

      //if (isUnix()) {
         sh 'mvn -Dmaven.test.failure.ignore=true install'
      //} 
      //else {
      //   bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
       }
//}
   }
   
   stage('sonarqube') {
    environment {
        scannerHome = tool 'sonarqube'
    }
    steps {
        withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
        }
      
        }
    }
    
     stage('Artifact upload') {
      steps {
     nexusPublisher nexusInstanceId: '1234', nexusRepositoryId: 'releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '/var/lib/jenkins/workspace/JOB-1/gameoflife-web/target/gameoflife.war']], mavenCoordinate: [artifactId: 'gameoflife1', groupId: 'com.wakaleo.gameoflife', packaging: 'war', version: '$BUILD_NUMBER']]]
      }
   }
     stage('Deployement war/ear file') {
      steps{
       deploy adapters: [tomcat8(credentialsId: '8844bccb-2fa4-4a07-8078-cf8256126665', path: '', url: 'http://3.18.226.65:8080/manager/html')], contextPath: '/var/lib/jenkins/workspace/CICD1/gameoflife-web/target', war: '**/*.war'       
      }
     }    
  }
         
  post {
        success {
            archiveArtifacts 'gameoflife-web/target/*.war'
        }
        failure {
            mail to:"shivarajkumar585@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Build failed"
        }
    }       
 }
