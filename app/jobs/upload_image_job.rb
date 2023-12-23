# frozen_string_literal: true

require 'uuid'
require 'aws-sdk-s3'

# Upload Image Job class
class UploadImageJob < ApplicationJob
  queue_as :default

  def perform(tempfile:, file_name:)
    s3 = Aws::S3::Resource.new(
      region: ENV['REGION_AWS'],
      credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
    )

    object_key = "#{SecureRandom.uuid}_#{file_name}"

    s3_object = s3.object.bucket(bucket_name).object(object_key)

    s3_object.upload_file(tempfile)

    @url = "https://s3.amazonaws.com/#{bucket_name}/#{object_key}"
  end
end
