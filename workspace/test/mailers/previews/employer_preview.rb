# Preview all emails at http://localhost:3000/rails/mailers/employer
class EmployerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/employer/mailer
  def mailer
    Employer.mailer
  end

end
