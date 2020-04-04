# the source block is what was defined in the builders section and represents a
# reusable way to start a machine. You build your images from that source. All
# sources have a 1:1 correspondance to what currently is a builder. The
# argument name (ie: ami_name) must be unquoted and can be set using the equal
# sign operator (=).
source "amazon-ebs" "example" {
    ami_name = "packer-test"
    region = "us-east-1"
    instance_type = "t2.micro"

    source_ami_filter {
        filters {
          virtualization-type = "hvm"
          name =  "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
          root-device-type = "ebs"
        }
        owners = ["amazon"]
        most_recent = true
    }

    communicator = "ssh"
    ssh_username = "ubuntu"
}

# A build starts sources and runs provisioning steps on those sources.
build {
  sources = [
    # there can be multiple sources per build
    "source.amazon-ebs.example"
  ]

  # All provisioners and post-processors have a 1:1 correspondence to their
  # current layout. The argument name (ie: inline) must to be unquoted
  # and can be set using the equal sign operator (=).
  provisioner "shell" {
    inline = ["sleep 5"]
  }

  # post-processors work too, example: `post-processor "shell-local" {}`.
}