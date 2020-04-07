# See
# https://packer.io/guides/hcl/from-json-v1/
# https://packer.io/docs/configuration/from-1.5/syntax.html
#
# https://github.com/nezumisannn/packer-hcl2-sample

variable "host_name" {
  type    = string
  default = "sfxpt"
}

variable "soft_version" {
  type    = string
  default = "01"
}

# the source block is what was defined in the builders section and represents a
# reusable way to start a machine. You build your images from that source. All
# sources have a 1:1 correspondance to what currently is a builder. The
# argument name (ie: ami_name) must be unquoted and can be set using the equal
# sign operator (=).

source "docker" "base" {
      image= "debian:bullseye"
      export_path= "export_image.tar"
}

# A build starts sources and runs provisioning steps on those sources.
build {
  sources = [
    # there can be multiple sources per build
    "source.docker.base"
  ]

  # All provisioners and post-processors have a 1:1 correspondence to their
  # current layout. The argument name (ie: inline) must to be unquoted
  # and can be set using the equal sign operator (=).
  provisioner "shell" {
    inline = [
    "sleep 2",
    "hostname -I",
    "echo ${var.host_name} | tee /etc/hostname",
    "hostname && cat /etc/os-release"
    ]
  }

  # post-processors work too, example: `post-processor "shell-local" {}`.
  post-processor  "docker-import" {
    repository = "${var.host_name}"
    tag = "bullseye_${var.soft_version}"
  }
}

