class NotificationMailer < Devise::Mailer
  default from: "raresapp@rares.com", reply_to: "raresapp@rares.com"
  layout "mail"
end
