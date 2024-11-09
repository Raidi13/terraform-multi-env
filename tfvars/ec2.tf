resource "aws_instance" "expense" {
  for_each = var.instances                # this variable is map 
  ami           = "ami-09c813fb71547fc4f" #this AMI ID may change over the time
  instance_type = each.value
  # security group reference
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id] #  security group ID 
  tags = merge(
           var.comman_tags,
           var.tags,
           {
            Name = each.key
           }
    )
}
# security group configuration
resource "aws_security_group" "allow_ssh_terraform" {
  name        = "allow_ssh_${var.environment}"
  description = "Allow port number 22 for SSH access"

  # Egress - allow all outgoing traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Ingress - allow incoming traffic on port 22 (SSH)
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Allow from everywhere
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.comman_tags,
    var.tags,
    {
      Name = "allow_ssh-${var.environment}"
    }
  )
}