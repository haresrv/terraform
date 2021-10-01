locals {
  availability_zone_id = {
    eu-west-1a = "Z1"
    eu-west-1b = "Z2"
    eu-west-1c = "Z3"
  }
}
resource "aws_instance" "ec2_instance" {
  count             = var.ec2_instance_count
  ami               = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.root_user_key_pair
  availability_zone = var.availability_zone

  tags = {
    type = "EC2 created from TFM"
    Name = "${lookup(local.availability_zone_id, var.availability_zone)}-${var.short_tag}${count.index + 1}"
  }

  vpc_security_group_ids = var.vpc_security_group_ids

}

# For attaching EBS volumes
resource "aws_ebs_volume" "ebs_volume" {
  count             = var.ec2_instance_count * var.ec2_ebs_volume_count
  availability_zone = element(aws_instance.ec2_instance.*.availability_zone, count.index)
  size              = element(var.ec2_ebs_volume_sizes, count.index)
}

resource "aws_volume_attachment" "volume_attachment" {
  count       = var.ec2_instance_count * var.ec2_ebs_volume_count
  volume_id   = aws_ebs_volume.ebs_volume.*.id[count.index]
  device_name = local.combinations[count.index].device_name
  instance_id = local.combinations[count.index].instance_id
}

locals {
  device_names = var.ec2_device_names
  instance_id  = aws_instance.ec2_instance.*.id
  combinations = [
    for pair in setproduct(local.instance_id, local.device_names) : {
      instance_id = pair[0]
      device_name = pair[1]
    }
  ]
}