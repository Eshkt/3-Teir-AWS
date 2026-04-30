#aws security group
resource "aws_security_group" "web_sg" {
    name = "${var.project_name}-web-sg"
    description = "Security group for web servers"
    vpc_id = var.vpc_id

    ingress = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] #open all
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["112.198.36.8/32"] #work ip address only
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] #open all
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] #open all
    }
    tags = { Name = "${var.project_name}-web-sg" }
}

#Export the security group id so that it can be used in other modules
output "web_sg_id" {
    value = aws_security_group.web_sg.id
}