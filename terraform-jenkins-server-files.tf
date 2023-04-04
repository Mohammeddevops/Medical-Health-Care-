provider aws {
    region = "us-east-1"
}
resource "aws_instance" "jenkins-server" {
  ami           = "ami-007855ac798b5175e" 
  instance_type = "t2.medium"
  key_name = "DEMOKEY"
  vpc_security_group_ids= ["sg-0c7aae9017fc5106b"]

   tags = {
    Name = "Jenkins-server"
  }
}

output "Jenkins-server_public_ip" {

  value = aws_instance.jenkins-server.public_ip
  
}
