# See https://github.com/nezumisannn/packer-hcl2-sample/blob/master/build.pkr.hcl

build {
  sources = [
    "source.docker.nginx",
    "source.docker.php-fpm"
  ]

  provisioner "shell" {
    inline = [
      "hostname && cat /etc/os-release"
    ]
  }
}
