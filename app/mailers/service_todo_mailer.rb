class ServiceTodoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_todo_mailer.new_service_todo_to_user.subject
  #
  def new_service_todo_to_user(service_todo)
    @service_todo = service_todo
    @service_transaction = @service_todo.service_transaction
    mail to: @service_transaction.car.user.email, subject: "Added #{@service_todo.service.name} for your Car #{@service_transaction.car.plate_number} "
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_todo_mailer.new_service_todo_to_staff.subject
  #
  def new_service_todo_to_staff(service_todo)
    @service_todo = service_todo
    @service_transaction = @service_todo.service_transaction
    mail to: @service_transaction.staff_in_charge.email, subject: "Added #{@service_todo.service.name} for your Car #{@service_transaction.car.plate_number} "
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.service_todo_mailer.new_service_todo_to_technician.subject
  #
  def new_service_todo_to_technician(service_todo)
    @service_todo = service_todo
    @service_transaction = @service_todo.service_transaction
    mail to: @service_todo.technician_in_charge.email , subject: "Added #{@service_todo.service.name} for your Car #{@service_transaction.car.plate_number} "
  end
   def on_going(service_todo)
    @service_todo = service_todo
    @service_transaction = @service_todo.service_transaction
    mail to: @service_transaction.car.user.email, subject: "Car #{@service_transaction.car.plate_number} service on-going "
  end
  
  def completed(service_todo)
    @service_todo = service_todo
    @service_transaction = @service_todo.service_transaction
    mail to: @service_transaction.car.user.email, subject: "Car #{@service_transaction.car.plate_number} service completed  "
  end
end
