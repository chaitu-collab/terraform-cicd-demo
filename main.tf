resource "aws_iam_role" "ec2_s3_role" {
  name = "Day40-EC2S3AccessRole"
  assume_role_policy = file("role-trust-policy.json")
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "day40-ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "Day40-S3ReadOnlyForEC2"
  description = "Allows EC2 instances to read from S3"
  policy      = file("s3-policy.json")
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy_to_role" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_instance" "example" {
  ami                         = "ami-083c4cc024d25f4c9" # ✅ Amazon Linux 2 (Mumbai)
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-xxxxxxxx"        # 🔁 Replace with actual subnet
  associate_public_ip_address = true
  key_name                    = "your-key-name"           # 🔁 Replace with actual key

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "Day40-EC2-With-S3-Access"
  }
}
