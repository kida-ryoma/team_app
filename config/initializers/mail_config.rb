ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: 'test.kida.ryoma@gmail.com',
  password: 'testkida39',
  authentication: 'plain',
  enable_starttls_auto: true
}