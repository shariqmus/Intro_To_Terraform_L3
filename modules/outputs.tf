output "module_bucket_name" {
  value       = aws_s3_bucket.terraform_bucket.id
}

output "module_queue_name" {
  value       = aws_sqs_queue.terraform_queue.id
}
