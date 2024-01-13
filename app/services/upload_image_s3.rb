# frozen_string_literal: true

require_relative '../clients/aws_client'

# Upload image s3 class
class UploadImageS3
  attr_accessor :tempfile, :file_name, :url

  def initialize(tempfile:, file_name:)
    @tempfile = tempfile
    @file_name = file_name
  end

  def upload
    raise ArgumentError, 'tempfile is required' unless @tempfile
    raise ArgumentError, 'file_name is required' unless @file_name

    s3 = Aws::S3::Resource.new(
      region: ENV['REGION_AWS'],
      credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
    )

    bucket_name = ENV['BUCKET_NAME']

    object_key = "#{SecureRandom.uuid}_#{file_name}"

    s3_object = s3.bucket(bucket_name).object(object_key)

    s3_object.upload_file(tempfile)

    @url = "https://#{ENV['BUCKET_NAME']}.s3.amazonaws.com/#{object_key}"
  end
end
