resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    control-plane:
      ansible_host: ${module.kub-control.external-ip}
    worker-node1:
      ansible_host: ${module.kub-worker1.external-ip}
    worker-node2:
      ansible_host: ${module.kub-worker2.external-ip}
    cicd-server:
      ansible_host: ${module.cicd.external-ip}
      ansible_user: centos
  children:
    kube_control_plane:
      hosts:
        control-plane:
    etcd:
      hosts:
        control-plane:
    kube_node:
      hosts:
        worker-node1:
        worker-node2:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    jenkins:
      hosts:
        cicd-server:
  vars:
    ansible_connection_type: paramiko
    ansible_user: ubuntu

DOC
  filename = "../ansible/hosts-${terraform.workspace}.yml"

  depends_on = [
    module.kub-control,
    module.kub-worker1,
    module.kub-worker2,
    module.cicd
  ]
}
