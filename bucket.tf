resource "aws_s3_bucket" "efuse" {
    bucket = "${var.bucket_name}" 
    acl = "${var.acl_value}"   
}
