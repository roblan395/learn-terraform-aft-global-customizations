data "aws_organizations_organization" "org" {}

resource "aws_organizations_policy" "deny_non_approved_regions" {
  name        = "deny-non-approved-regions"
  description = "Permitir solo us-east-1 y us-west-2"

  content = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Deny",
        Action    = "*",
        Resource  = "*",
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = ["us-east-1", "us-west-2"]
          }
        }
      },
      # Excepciones para servicios globales
      {
        Effect    = "Allow",
        Action    = [
          "iam:*",
          "organizations:*",
          "sso:*",
          "cloudfront:*"
        ],
        Resource  = "*"
      }
    ]
  })
}

# Aplicar política a toda la organización
resource "aws_organizations_policy_attachment" "aft_restrict_regions" {
  policy_id = aws_organizations_policy.deny_non_approved_regions.id
  target_id = data.aws_organizations_organization.org.roots[0].id
}
