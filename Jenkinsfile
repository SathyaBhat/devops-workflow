ansiColor('css') {
    node {
          stage('Preparation') { // for display purposes
          // Get some code from a GitHub repository
          git 'https://github.com/sathya-demo/hello-world.git'
       }
       stage('Build') {
          sh 'pip install -r code/requirements.txt'
       }
       stage('Test') {
           sh 'cd code && python hello_test.py'
       }
       stage('Validate Packer Box') {
           withAWS(credentials:'sathyabhat', region:'ap-south-1') {
               sh 'packer validate packer/packer-box.json'
           }
       }
       stage('Validate Ansible Playbook') {
           withAWS(credentials:'sathyabhat', region:'ap-south-1') {
               sh 'ansible-playbook --syntax-check ansible/setup.yml'
           }
       }   
       stage('Bake AMI') {
           withAWS(credentials:'sathyabhat', region:'ap-south-1') {
               withCredentials([string(credentialsId: 'datadog', variable: 'dd_token')]) {
                    sh 'DD_TOKEN=${dd_token} packer build packer/packer-box.json'
               }
           }
       }
       stage('Launch Instance') {
           withAWS(credentials: 'sathyabhat', region:'ap-south-1') {
               sh('cd terraform && terraform init && terraform plan && terraform -auto-approve apply')
           }
       }
    }
}
