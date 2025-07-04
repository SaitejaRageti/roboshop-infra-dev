#!/bin/bash
# cd 00.vpc ; terraform destroy -auto-approve 

# cd ../1o-sg ; terraform destroy -auto-approve

for i in 00.vpc 10-sg 20-bastion 50-backend-alb ;
    do cd $i/ ; terraform apply -auto-approve ; cd ..
done
