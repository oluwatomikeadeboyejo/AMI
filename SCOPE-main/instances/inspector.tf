resource "aws_inspector_resource_group" "scope_res" {
  tags = {
    Name = "Test_Instance"
    Env  = "dev"
  }
  depends_on = [aws_instance.test_ami_server]
}

resource "aws_inspector_assessment_target" "assessment" {
  name               = "Hardening Assessment"
  resource_group_arn = aws_inspector_resource_group.scope_res.arn
}

resource "aws_inspector_assessment_template" "scope_hardening_rules" {
  name       = "scope_rules"
  target_arn = aws_inspector_assessment_target.assessment.arn
  duration   = 3600

  rules_package_arns = [
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-gEjTy7T7",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-rExsr2X8",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd",
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-R01qwB5Q",
  ]
}

output "assessment_template_arn" {
    value=aws_inspector_assessment_template.scope_hardening_rules.arn
}