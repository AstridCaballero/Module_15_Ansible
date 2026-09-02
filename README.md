![img.png](img.png)
## Module 15 - Configuration Management with Ansible

### Chapter 20 - Deploying Application in K8s

Notes from chapter 20 were taken in notes app in freestyle, and it includes a mix of screenshots of TWN bootcamp as well as
screenshots of my own work on the terminal and browser. I used AI and I have added that research to my notes.

Notes have been exported into pdf format to be able to get the screenshots (avoiding retaking screenshots which is time-consuming)

You can find original notes for
- Chapter 20 [here](Module%2015%20-%20chapter%2020_notes.pdf).

### Description
Up to this point we were configuring the servers IP addresses in the ‘hosts’ file for Ansible to use, in this chapter we used terraform to deploy an app into a Kubernetes Cluster where we don’t provide the servers directly.

Here we used two projects 

Terraform project:
https://github.com/AstridCaballero/Module_12_Terraform/tree/Module_15/Ansible_chapter-20_EKS

Ansible Project:
https://github.com/AstridCaballero/Module_15_Ansible/tree/Module_15/Ansible_chapter-20_Ansible

1. Go to TF project
    1. I provisioned an EKS cluster using file ‘eke-cluster.yaml’ created during work at Module 12 - chapter 21.
    2. I made a copy of my global kubeconfig file and call it ‘kubeconfig_myapp-eks-cluster’ and paste it in the TF project. We need this kubeconfigfile as it has the information (address + credentials) to get ansible to connect to our cluster
2. Switch to the Ansible project 
    1. We use ‘K8s’ Ansible module so I installed the requirements to execute the module in my venv of my Pycharm Ansible project:
        1. Python >= 3.9
        2. Kubernetes >= 24.2.0
        3. pyYAML >= 3.11
        4. jsonpatch
    2. Edited ‘ansible.cfg’ file 
        1. To tell Ansible where to find the python interpreter which is in my venv -> interpreter_python
        2. To tell Ansible to use ‘localhost’ I set ‘inventory’ to ‘hosts’ as this file doesn’t have ‘localhost’ in it config so Ansible will behave as if there is no inventory at all and fall back to its implicit built-in localhost.
    3. create a new ansible playbook ‘deploy-to-k8s.yaml’ 
        1. Set attribute ‘hosts’ to ‘localhost’ -> in order to execute ansible locally in my laptop
        2. Write a play to create a namespace
            1. Set attribute ‘name’ to ‘my-app’
            2. Set attribute ‘kind’ to ‘Namespace’
            3. Set attribute ’state’ to ‘present’
            4. Set attribute ‘kubeconfig’ to the TF ‘kubeconfig_myapp-eks-cluster’ file -> so ansible can fetch the kubeconfig and execute it locally.
        3. Write a play to deploy nginx app
            1. Make sure my TF project has a nginx deployment and service configuration file, and it does -> ’Nginx-config.yaml’. This is the yaml file that Ansible will call and execute using the’ k8s’ module instead of using kubectl to create the deployment.
            2. Set attribute ‘src’ to the path of ‘Nginx-config.yaml’
            3. Set attribute ‘kubeconfig’ to the TF ‘kubeconfig_myapp-eks-cluster’ file -> so ansible can fetch the kubeconfig and execute it locally.
            4. Set attribute ‘namespace’ to ‘my-app’ (the name of the namespace created in the first play)
            5. Set attribute ’state’ to ‘present’
        4. Execute the playbook and check the EKS cluster and the app was running.
        5. Improvement:
            1. removed attribute ‘kubeconfig’ from the playbook as it was repetitive and inefficient 
            2. Set in the terminal an env var called ‘K8S_AUTH_KUBECONFIG’ ants set it to ‘~/terraform/kubeconfig_myapp-eks-cluster’

I learnt how to connect Ansible with an AWS EKS cluster using kubeconfig file and ‘K8s’ Ansible module to deploy an app using terraform.
