variable "description" {
  type    = string
  default = "adrianpardo.dev-server"
}

variable "access_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "secret_key" {
  type      = string
  default   = ""
  sensitive = true
}

source "amazon-ebs" "aws" {
  access_key    = "${var.access_key}"
  ami_name      = "${var.description}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  secret_key    = "${var.secret_key}"
  source_ami    = "ami-0e472ba40eb589f49"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.aws"]

  provisioner "file" {
    destination = "/tmp/adrianpardo.dev"
    source      = "adrianpardo.dev-nginx-config"
  }

  provisioner "shell" {
    environment_vars = ["ACCESS_KEY=${var.access_key}", "SECRET_KEY=${var.secret_key}"]
    script           = "setup.sh"
  }

  post-processor "manifest" {
    output = "output-${var.description}.json"
  }
}
