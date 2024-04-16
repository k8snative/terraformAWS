resource "aws_ecr_repository" "TbECRqa" {
  name = "tbecrrepo${var.environment_name}"
}

resource "aws_ssm_parameter" "MySSMParameter" {
  name        = "/tbenv/ecr${var.environment_name}"
  description = "My parameter value"
  type        = "String"
  value       = aws_ecr_repository.TbECRqa.repository_url
}


output "TbECRqaName" {
  description = "The name of the ECR repository created"
  value       = aws_ecr_repository.TbECRqa.name
}

output "TbECRqaUri" {
  description = "The URI of the ECR repository created"
  value       = aws_ecr_repository.TbECRqa.repository_url
}