Aws.config.update({
  region: QanvastApi::Application.secrets['AWS_REGION'],
  credentials: Aws::Credentials.new(QanvastApi::Application.secrets['AWS_ACCESS_KEY_ID'], QanvastApi::Application.secrets['AWS_SECRET_KEY']),
})

# S3_BUCKET = Aws::S3::Resource.new.bucket(QanvastApi::Application.secrets['AWS_DIRECTORY'])
 S3_BUCKET = Aws::S3::Resource.new.bucket(QanvastApi::Application.secrets['AWS_DIRECTORY'])
