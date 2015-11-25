class ApplicationMailer < ActionMailer::Base
  default from: ENV['PONY_MAIL']
  layout 'mailer'
end
