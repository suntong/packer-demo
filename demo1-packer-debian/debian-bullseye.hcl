
"variables" = {
  "debian_version" = "11"
  "iso_checksum" = ""
  "soft_version" = "01"
  "ansible_environment" = "dev"
}

"builders" = [{
  "type" = "virtualbox-iso"
},
{
  "type" = "docker"
  "image" = "debian:bullseye"
  "export_path" = "debian.tar"
}]

"post-processors" = {
  "only" = ["docker"]
  "type" = "docker-import"
  "repository" = "sfxpt"
  "tag" = "bullseye-{{user `debian_version`}}_{{user `soft_version`}}"
}

"provisioners" = {
  "only" = ["virtualbox-iso"]
  "type" = "shell"
  "execute_command" = "echo 'vagrant' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
  "scripts" = [
    "scripts/update.sh",
    "scripts/sshd.sh",
    "scripts/networking.sh",
    "scripts/sudoers.sh",
    "scripts/vagrant.sh",
    "scripts/vbaddguest.sh",
    "scripts/ansible.sh"]
}

"provisioners" = {
  "only" = ["docker"]
  "type" = "shell"
  "scripts" = [
    "scripts/update.sh",
    "scripts/sshd.sh",
    "scripts/sudoers.sh"]
}

"provisioners" = {
  "only" = ["virtualbox-iso"]
  "type" = "shell"
  "execute_command" = "echo 'vagrant' | {{.Vars}} sudo -E -S bash '{{.Path}}'"
  "scripts" = ["scripts/cleanup.sh"]
}

"provisioners" = {
  "only" = ["docker"]
  "scripts" = ["scripts/cleanup.sh"]
  "type" = "shell"
}
