# output "az_names" {
#   value = module.aws_vpc.az_names
# }

# output "public_subnet" {
  
#   value = module.aws_vpc.aws_public_subnet
# }

output "vpc_id" {
   value = module.aws_vpc.vpc_id
  
}

output "default_vpc_id" {
  
  value = module.aws_vpc.default_vpc_id
}

# output "perring_coonection_id" {
#     value =module.aws_vpc.peering_connection_id
# }