ACCESS_KEY = "$(shell cd ./terraform-state-bucket && terraform output -raw backend-access-key)"
SECRET_KEY = "$(shell cd ./terraform-state-bucket && terraform output -raw backend-secret-key)"
#REGISTRY_ID := "$(shell cd ./terraform-infrastructure && AWS_ACCESS_KEY_ID=$(ACCESS_KEY) AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) terraform output -raw registry-id)"

default:

all: create_bucket create_infrastructure destroy_infrastructure destroy_bucket

create_bucket:
	cd ./terraform-state-bucket && terraform init
	cd ./terraform-state-bucket && terraform validate
	cd ./terraform-state-bucket && terraform plan
	cd ./terraform-state-bucket && terraform apply -auto-approve
	echo "Still creating" && sleep 10

destroy_bucket:
	cd ./terraform-state-bucket && terraform destroy -auto-approve

create_workspaces:
	@export AWS_ACCESS_KEY_ID=$(ACCESS_KEY) && \
	export AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) && \
	cd ./terraform-infrastructure && terraform workspace new prod && \
	terraform workspace new stage

destroy_workspaces:
	@export AWS_ACCESS_KEY_ID=$(ACCESS_KEY) && \
	export AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) && \
	cd ./terraform-infrastructure && terraform workspace select default && \
	terraform workspace delete prod && \
	terraform workspace delete stage

create_infrastructure:
	@export AWS_ACCESS_KEY_ID=$(ACCESS_KEY) && \
	export AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) && \
	cd ./terraform-infrastructure && terraform workspace select $(WORKSPACE) && \
	terraform init && \
	terraform validate && \
	terraform plan && \
	terraform apply -auto-approve
	echo "Still creating" && sleep 30

destroy_infrastructure:
	@export AWS_ACCESS_KEY_ID=$(ACCESS_KEY) && \
	export AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) && \
	cd ./terraform-infrastructure && terraform workspace select $(WORKSPACE) && \
	terraform destroy -auto-approve

REGISTRY_ID = "$(shell cd ./terraform-infrastructure && AWS_ACCESS_KEY_ID=$(ACCESS_KEY) AWS_SECRET_ACCESS_KEY=$(SECRET_KEY) terraform output -raw registry-id)"

install_kub:
	@cd ansible && ansible-playbook -i hosts-$(WORKSPACE).yml -e "workspace=$(WORKSPACE)" -e 'registry_id=$(REGISTRY_ID)' -e 'bucket_access_key=$(ACCESS_KEY)' -e 'bucket_secret_key=$(SECRET_KEY)' site.yml

create: create_bucket create_workspaces create_infrastructure install_kub

destroy: destroy_infrastructure destroy_workspaces destroy_bucket
