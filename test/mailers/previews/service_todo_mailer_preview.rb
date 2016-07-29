# Preview all emails at http://localhost:3000/rails/mailers/service_todo_mailer
class ServiceTodoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/service_todo_mailer/new_service_todo_to_user
  def new_service_todo_to_user
    service_todo = ServiceTodo.last
    ServiceTodoMailer.new_service_todo_to_user(service_todo)
  end

  # Preview this email at http://localhost:3000/rails/mailers/service_todo_mailer/new_service_todo_to_staff
  def new_service_todo_to_staff
    service_todo = ServiceTodo.last
    ServiceTodoMailer.new_service_todo_to_staff(service_todo)
  end

  # Preview this email at http://localhost:3000/rails/mailers/service_todo_mailer/new_service_todo_to_technician
  def new_service_todo_to_technician
    service_todo = ServiceTodo.last
    ServiceTodoMailer.new_service_todo_to_technician(service_todo)
  end

  def on_going
    service_todo = ServiceTodo.last
    ServiceTodoMailer.on_going(service_todo)
  end


  def completed
    service_todo = ServiceTodo.last
    ServiceTodoMailer.completed(service_todo)
  end

end
