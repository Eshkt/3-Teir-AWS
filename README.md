# 3-Teir AWS



## Getting started

To make it easy for you to get started with GitLab, here's a list of recommended next steps.

Already a pro? Just edit this README.md and make it your own. Want to make it easy? [Use the template at the bottom](#editing-this-readme)!

## Add your files

* [Create](https://docs.gitlab.com/user/project/repository/web_editor/#create-a-file) or [upload](https://docs.gitlab.com/user/project/repository/web_editor/#upload-a-file) files
* [Add files using the command line](https://docs.gitlab.com/topics/git/add_files/#add-files-to-a-git-repository) or push an existing Git repository with the following command:

```
cd existing_repo
git remote add origin https://gitlab.com/franky.parcon/3-teir-aws.git
git branch -M main
git push -uf origin main
```

## Integrate with your tools

* [Set up project integrations](https://gitlab.com/franky.parcon/3-teir-aws/-/settings/integrations)

## Collaborate with your team

* [Invite team members and collaborators](https://docs.gitlab.com/user/project/members/)
* [Create a new merge request](https://docs.gitlab.com/user/project/merge_requests/creating_merge_requests/)
* [Automatically close issues from merge requests](https://docs.gitlab.com/user/project/issues/managing_issues/#closing-issues-automatically)
* [Enable merge request approvals](https://docs.gitlab.com/user/project/merge_requests/approvals/)
* [Set auto-merge](https://docs.gitlab.com/user/project/merge_requests/auto_merge/)

## Test and Deploy

Use the built-in continuous integration in GitLab.

* [Get started with GitLab CI/CD](https://docs.gitlab.com/ci/quick_start/)
* [Analyze your code for known vulnerabilities with Static Application Security Testing (SAST)](https://docs.gitlab.com/user/application_security/sast/)
* [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/topics/autodevops/requirements/)
* [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/user/clusters/agent/)
* [Set up protected environments](https://docs.gitlab.com/ci/environments/protected_environments/)

***
## Roadmap
"""# Secure 3-Tier AWS Architecture with Terraform & GitLab CI/CD

## 🏗️ Architecture Overview
This project implements a highly secure, scalable, and automated 3-tier web architecture on AWS. It leverages Infrastructure as Code (IaC) with Terraform and a robust DevSecOps pipeline via GitLab CI/CD.

### The Stack:
* **Web Tier:** Nginx Reverse Proxy on EC2 (Public Subnets).
* **App Tier:** Python FastAPI/Flask Microservice on EC2 (Private Subnets).
* **Data Tier:** Amazon RDS (PostgreSQL/MySQL) in isolated private subnets.
* **Serverless:** AWS Lambda triggered by S3/API Gateway for async processing.

---

## 🌐 Networking & CIDR Strategy
The VPC is designed with strict isolation across two Availability Zones (AZs) for High Availability.

| Tier | Subnet Type | CIDR AZ-A | CIDR AZ-B | Access Control |
| :--- | :--- | :--- | :--- | :--- |
| **Web** | Public | `10.0.1.0/24` | `10.0.2.0/24` | IGW / 80, 443 |
| **App** | Private | `10.0.10.0/24` | `10.0.11.0/24` | NAT Gateway |
| **Data** | Isolated | `10.0.20.0/24` | `10.0.21.0/24` | Internal Only |

---

## 🔒 Security & Governance Standards
1.  **Least Privilege SGs:** Security Groups are "chained." The Database only accepts traffic from the App Tier SG ID, and the App Tier only from the Web Tier SG ID.
2.  **Secret Management:** RDS credentials and API keys are managed via **AWS Secrets Manager**.
3.  **JIT Access:** SSH is disabled by default. Access is managed via **AWS SSM Session Manager** or temporary IP whitelisting.
4.  **State Management:** Terraform state is stored in an S3 bucket with **DynamoDB** for state locking to prevent concurrent modifications.

---

## 🚀 CI/CD Pipeline Stages
The `.gitlab-ci.yml` is structured into four critical stages:

1.  **Validate:** Runs `terraform validate` and `tflint` to ensure code quality and syntax correctness.
2.  **Plan:** Runs `terraform plan` and saves the output. Includes a security scan of the plan (e.g., using `tfsec`).
3.  **Apply:** Deploys the infrastructure to AWS (Manual trigger for Production).
4.  **Verify:** * Uses `jq` to parse API telemetry.
    * Performs an end-to-end health check: `Public IP -> Web -> App -> DB`.

---

## 📂 Project Structure
```text
.
├── modules/
│   ├── vpc/             # VPC, IGW, NAT, Route Tables
│   ├── security/        # Security Groups & IAM Roles
│   ├── compute/         # EC2 instances & Auto Scaling
│   ├── database/        # RDS Instance
│   └── serverless/      # Lambda & S3 Triggers
├── environments/
│   └── prod/
│       ├── main.tf      # Root configuration
│       ├── variables.tf # Environment variables
│       └── backend.tf   # S3 Backend config
├── scripts/
│   └── health-check.sh  # JQ-based connectivity validation
└── .gitlab-ci.yml       # CI/CD Pipeline

