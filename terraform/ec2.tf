# Frontend EC2 Instance (Web Server)
resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.frontend_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Frontend server is running" > /var/www/html/index.html
              EOF

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-frontend"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Backend EC2 Instance
resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.backend_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nodejs npm
              echo "Backend server is ready for configuration" > /home/ec2-user/backend-ready.txt
              EOF

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-backend"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Database EC2 Instance
resource "aws_instance" "database" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.database.id]
  key_name               = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y sqlite
              echo "Database server is ready for configuration" > /home/ec2-user/database-ready.txt
              EOF

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-database"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Elastic IP for Frontend
resource "aws_eip" "frontend" {
  instance = aws_instance.frontend.id
  vpc      = true

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-frontend-eip"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Elastic IP for Backend
resource "aws_eip" "backend" {
  instance = aws_instance.backend.id
  vpc      = true

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-backend-eip"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Elastic IP for Database
resource "aws_eip" "database" {
  instance = aws_instance.database.id
  vpc      = true

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-database-eip"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Alternative approach: If you need to keep both instances separate
# WARNING: Running both instances simultaneously will exceed Free Tier limits
# Uncomment the following if you prefer separate instances but be aware of potential costs
/*
# Frontend EC2 Instance (Web Server)
resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.frontend_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = var.ssh_key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Frontend server is running" > /var/www/html/index.html
              EOF

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-frontend"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Backend EC2 Instance (now in public subnet)
resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.backend_instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = var.ssh_key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nodejs npm
              echo "Backend server is ready for configuration" > /home/ec2-user/backend-ready.txt
              EOF

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-backend"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Elastic IP for Frontend
resource "aws_eip" "frontend" {
  instance = aws_instance.frontend.id
  vpc      = true

  tags = merge(
    var.project_tags,
    {
      Name = "devops-project-frontend-eip"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}
*/
