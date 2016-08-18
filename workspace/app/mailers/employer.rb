class Employer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.employer.mailer.subject
  #
  def mailer
    @greeting = "Hi"

    mail to: "vishnuknair1205@gmail.com"
  end
end
