pipeline {
agent any 
tools {
maven 'maven'
}

stages {
stage("Git Checkout"){
steps{
git 'https://github.com/SaiRevanth-J/project-03-medicure.git'
 }
 }
stage('Build the application'){
steps{
echo 'cleaning..compiling..testing..packaging..'
sh 'mvn clean install package'
 }
 }
 
stage('Publish HTML Report'){
steps{
 publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: 
false, reportDir: '/var/lib/jenkins/workspace/Project-03-medicure/target/surefirereports', reportFiles: 'index.html', reportName: 'medicure-HTML Report', reportTitles: '', useWrapperFileDirectly: true])
 }
}
stage('Docker build image') {
              steps {
                  
                  sh'sudo docker system prune -af '
                  sh 'sudo docker build -t revanthkumar9/medicure:latest. '
              
                }
            }
stage('Docker login and push') {
              steps {
                   withCredentials([string(credentialsId: 'docpass', variable: 'docpasswd')]) {
                  sh 'sudo docker login -u revanthkumar9 -p ${docpasswd} '
                  sh 'sudo docker push revanthkumar9/medicure:latest'
                  }
                }
        }    
 stage (' setting up Kubernetes with terraform & deploying '){
            steps{

                dir('terraform_files'){
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
               
            }
        }
stage('deploy to kubernetes'){
steps{
sshagent(['K8s']) {
sh 'scp -o StrictHostKeyChecking=no deployment.yml ubuntu@172.42.22.152:/home/ubuntu'
script{
try{
sh 'ssh ubuntu@172.42.22.152 kubectl apply -f .'
}catch(error)
{
sh 'ssh ubuntu@172.42.22.152 kubectl create -f .'
}
}
}
}
}
}
}