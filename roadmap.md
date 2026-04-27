.
├── modules/
│   ├── vpc/             # VPC, Subnets, IGW, NAT, Route Tables
│   ├── security/        # SG rules (Tier-to-Tier logic)
│   ├── compute/         # EC2 (Web & App), Launch Templates
│   ├── database/        # RDS Instance & Subnet Groups
│   └── serverless/      # Lambda, IAM roles, S3/API Gateway triggers
├── environments/
│   └── prod/
│       ├── main.tf      # Root module calling the modules above
│       ├── variables.tf # Environment-specific CIDRs/Instance types
│       ├── outputs.tf
│       └── backend.tf   # S3 + DynamoDB for State Locking
└── .gitlab-ci.yml       # The 4-stage pipeline definition