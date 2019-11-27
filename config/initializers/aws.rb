Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials:Aws::Credentials.new(ENV['SES_ACCESS_KEY_ID'], ENV['SES_SECRET_ACCESS_KEY']),
  region: 'us-east-1'
)