class ServiceTransactionMailer < ApplicationMailer

  def finished(service_transaction)
    @service_transaction = service_transaction
    mail to: @service_transaction.car.user.email, subject: "Added new transaction for your Car #{@service_transaction.car.plate_number} "    
  end

  def new_service_transaction_to_user(service_transaction)
    @service_transaction = service_transaction
    mail to: @service_transaction.car.user.email, subject: "Added new transaction for your Car #{@service_transaction.car.plate_number} "
  end


  def new_service_transaction_to_staff(service_transaction)
    @service_transaction = service_transaction
    mail to: @service_transaction.staff_in_charge.email, subject: "Added new transaction for your Car #{@service_transaction.car.plate_number} "
  end


  def new_service_transaction_to_technician(service_transaction)
    @service_transaction = service_transaction
    mail to: @service_transaction.technician_in_charge.email , subject: "Added new transaction for your Car #{@service_transaction.car.plate_number} "
  end
end
