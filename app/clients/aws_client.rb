# frozen_string_literal: true

require 'aws-sdk-s3'

# AWS client class
class AwsClient
  def initialize(object:)
    @object = object
  end


  object = Aws::S3::Resource.new(
    region: ENV['REGION_AWS'],
    credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
  )
end
