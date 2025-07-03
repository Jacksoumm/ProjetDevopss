output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "frontend_instance_id" {
  description = "The ID of the frontend EC2 instance"
  value       = aws_instance.frontend.id
}

output "frontend_public_ip" {
  description = "The public IP address of the frontend EC2 instance"
  value       = aws_eip.frontend.public_ip
}

output "frontend_public_dns" {
  description = "The public DNS name of the frontend EC2 instance"
  value       = aws_eip.frontend.public_dns
}

output "backend_instance_id" {
  description = "The ID of the backend EC2 instance"
  value       = aws_instance.backend.id
}

output "backend_public_ip" {
  description = "The public IP address of the backend EC2 instance"
  value       = aws_eip.backend.public_ip
}

output "backend_public_dns" {
  description = "The public DNS name of the backend EC2 instance"
  value       = aws_eip.backend.public_dns
}

output "database_instance_id" {
  description = "The ID of the database EC2 instance"
  value       = aws_instance.database.id
}

output "database_public_ip" {
  description = "The public IP address of the database EC2 instance"
  value       = aws_eip.database.public_ip
}

output "database_public_dns" {
  description = "The public DNS name of the database EC2 instance"
  value       = aws_eip.database.public_dns
}

output "frontend_security_group_id" {
  description = "The ID of the frontend security group"
  value       = aws_security_group.frontend.id
}

output "backend_security_group_id" {
  description = "The ID of the backend security group"
  value       = aws_security_group.backend.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}
