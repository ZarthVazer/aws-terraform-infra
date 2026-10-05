ENV ?= dev
DIR := environments/$(ENV)

.PHONY: fmt lint security init plan apply destroy

fmt:            ## Format all Terraform files
	terraform fmt -recursive

lint:           ## Run tflint on all directories
	tflint --init && tflint --recursive

security:       ## Scan Terraform code for misconfigurations
	trivy config --severity HIGH,CRITICAL .

init:           ## terraform init for ENV (default: dev)
	terraform -chdir=$(DIR) init

plan: init      ## terraform plan for ENV
	terraform -chdir=$(DIR) plan -out=tfplan

apply:          ## Apply the saved plan for ENV
	terraform -chdir=$(DIR) apply tfplan

destroy:        ## Destroy ENV (asks for confirmation)
	terraform -chdir=$(DIR) destroy
