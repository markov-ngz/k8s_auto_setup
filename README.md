# Automatic Kubernetes Development cluster setup

Repository dedicated to the creation of an automatic k8s cluster.<br>
Please not that the terraform scripts automatically write the ansible's inventory yml file as the instances's ips are not fixed. 

## Setup the cluster 

0. Prerequisites
The following configuration was used for this project : 
- <b>terraform</b> : 1.9.4
- <b>ansible</b> : ( core : 2.17.2 , python : 3.10.12 ) 
- <b>aws-cli</b> : 2.17.27 

1. Create key (if not already created)
```
ssh-keygen -t rsa -b 2048 -f kubernetes
```

2. Setup the following environment variables : 
```
TF_VAR_public_ip = $(curl -s ifconfig.me)  # your public ip to allow only ssh from your ip 
TF_VAR_public_key_path = <path_to_your_public_key>
# Optional : 
TF_VAR_ansible_user = <ansible_ssh_user>
```

3. Run the following commands : 

- In the ./terraform folder
```
terraform init
terraform apply -auto-approve
```
- In the ./ansible folder 
```
ansible-playbook -i ./inventory/inventory.yml  --key-file <path_to_key> playbook_k8s_setup.yml
```
## Cite and share
Please add the license to your work or add a star to the repository 😊 It would really help my career !
## Running on Windows ? 
Ansible is not available for Windows, hence : <br>
Install WSL and use Ubuntu distro ! <br>
Open Ubuntu bash for wsl form windows cmd
```
wsl --distribution Ubuntu --cd ~ --user $wsl_user
```