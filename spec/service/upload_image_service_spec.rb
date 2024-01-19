# spec/upload_image_s3_spec.rb

require 'securerandom'
require 'rails_helper'

RSpec.describe UploadImageS3 do
  let(:tempfile) { 'tempfile' }
  let(:file_name) { 'c.png' }

  before do
    allow(SecureRandom).to receive(:uuid).and_return('random_uuid')
  end

  describe '#upload' do
    it 'uploads file to S3 and generates a valid URL' do
      s3_double = instance_double(Aws::S3::Resource)
      bucket_double = instance_double(Aws::S3::Bucket)
      object_double = instance_double(Aws::S3::Object)

      allow(Aws::S3::Resource).to receive(:new).and_return(s3_double)
      allow(s3_double).to receive(:bucket).with(ENV['BUCKET_NAME']).and_return(bucket_double)
      allow(bucket_double).to receive(:object).and_return(object_double)
      allow(object_double).to receive(:upload_file)

      upload_image = UploadImageS3.new(tempfile: tempfile, file_name: file_name)
      upload_image.upload

      expect(upload_image.url).to eq("https://#{ENV['BUCKET_NAME']}.s3.amazonaws.com/random_uuid_c.png")
    end
  end
end
