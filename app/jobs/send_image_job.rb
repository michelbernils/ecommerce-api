# frozen_string_literal: true

require 'aws-sdk-s3'

# SendImageSDK Job
class SendImageJob < ApplicationJob
  queue_as :default
  
  def perform(bucket_name:, image_path:, file_name:)
  s3 = Aws::S3::Resource.new(
    region: ,
    access_key_id: ,
    secret_access_key:
  )
  end
end
