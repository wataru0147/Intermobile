# Preview all emails at http://localhost:3000/rails/mailers/service_transaction_mailer
class ServiceTransactionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/service_transaction_mailer/new_service_transaction_to_user
 def new_service_transaction_to_user
    service_transaction = ServiceTransaction.last
    ServiceTransactionMailer.new_service_transaction_to_user(service_transaction)
  end

  # Preview this email at http://localhost:3000/rails/mailers/service_transaction_mailer/new_service_transaction_to_staff
  def new_service_transaction_to_staff
    service_transaction = ServiceTransaction.last
    ServiceTransactionMailer.new_service_transaction_to_staff(service_transaction)
  end

  # Preview this email at http://localhost:3000/rails/mailers/service_transaction_mailer/new_service_transaction_to_technician
  def new_service_transaction_to_technician
    service_transaction = ServiceTransaction.last
    ServiceTransactionMailer.new_service_transaction_to_technician(service_transaction)
  end
   def finished
    service_transaction = ServiceTransaction.last
    ServiceTransactionMailer.finished(service_transaction)
  end
end
