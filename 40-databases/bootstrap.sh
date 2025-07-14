#!/bin/bash

component=$1
env=$2

dnf install ansible -y

ansible-pull -U https://github.com/SaitejaRageti/Ansible_Rboshop_roles_s.git -e component=$1 -e env=$2 main.yaml