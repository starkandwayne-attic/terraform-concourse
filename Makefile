.PHONY: all plan apply destroy provision ssh

all: plan apply provision

plan:
	terraform get -update
	terraform plan -module-depth=-1 -var-file terraform.tfvars -out terraform.tfplan

apply:
	terraform apply -var-file terraform.tfvars

destroy:
	terraform plan -destroy -var-file terraform.tfvars -out terraform.tfplan
	terraform apply terraform.tfplan

clean:
	rm -f terraform.tfplan
	rm -f terraform.tfstate
	rm -fR .terraform/

provision:
	./provision/prepare-provision
	./provision/provision-ssh

ssh:
	./provision/bastion-ssh

test:
	./scripts/testPlan
