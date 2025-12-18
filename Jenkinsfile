pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out code from GitHub..."
                git branch: 'main',
                    url: 'https://github.com/Deepauk14/jenkins_ec2_create.git'
            }
        }

        stage('Terraform Steps') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    script {
                        // Check if Terraform exists
                        def terraformCheck = bat(script: 'terraform -version', returnStatus: true)
                        if (terraformCheck != 0) {
                            error "Terraform is not installed or not in PATH! Please install Terraform and restart Jenkins."
                        }

                        echo "Terraform is installed. Proceeding with Init, Plan, Apply..."

                        // Initialize Terraform
                        bat 'terraform init'

                        // Terraform Plan
                        bat 'terraform plan'

                        // Terraform Apply
                        bat 'terraform apply -auto-approve'
                    } // closes script
                } // closes withCredentials
            } // closes steps
        } // closes stage
