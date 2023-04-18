resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }

  // This resource will fail the Sinistral scan because it's missing a KMS key.
  // Uncomment the line below to make the scan pass.
  //kms_master_key_id = "alias/aws/sqs"
}
