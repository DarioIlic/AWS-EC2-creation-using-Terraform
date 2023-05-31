# Define the security group for the EC2 Instance
resource "aws_security_group" "aws-vm-sg" {
  name        = "aws-terraform-sg"
  description = "Allow incoming connections"
  vpc_id      = aws_vpc.vpc.id  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["93.141.139.28/32"]
    description = "Allow incoming HTTPS connections"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["93.141.139.28/32"]
    description = "Allow incoming HTTP connections"
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["93.141.139.28/32"]
    description = "Allow incoming HTTPS connections"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}
# Create EC2 Instance
resource "aws_instance" "vm-server" {
  ami                    = data.aws_ami.ubuntu-linux-2004.id
  instance_type          = var.vm_instance_type
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.aws-vm-sg.id]
  source_dest_check      = false
  key_name               = aws_key_pair.key_pair.key_name
  associate_public_ip_address = var.vm_associate_public_ip_address
  
  user_data = file("user-data.sh")
  
  # root disk
  root_block_device {
    volume_size           = var.vm_root_volume_size
    volume_type           = var.vm_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }
  
  tags = {
    Name = "AWS-Terraform"
  }
}
