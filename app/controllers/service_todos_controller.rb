class ServiceTodosController < ApplicationController
  before_action :set_service_transaction#, only: [:on_going, :completed]
  before_action :set_service_todo , except: [:create]
  # GET /service_todos
  # GET /service_todos.json
  
  # GET /service_todos/new
  def new
    @service_todo = ServiceTodo.new
  end

  # GET /service_todos/1/edit
  # def edit
  # end

  # POST /service_todos
  # POST /service_todos.json
  def create
   
    @service_todo = ServiceTodo.new(service_todo_params)
    @service_todo = ServiceTodo.create(params[:service_todo].permit(:service_id, :technician_in_charge_id))
    @service_todo.service_transaction_id = @service_transaction.id

    if current_user.role.name == "staff" || current_user.role.name == "admin"
      if @service_todo.save
        ServiceTodoMailer.new_service_todo_to_staff(@service_todo).deliver_later
        ServiceTodoMailer.new_service_todo_to_user(@service_todo).deliver_later
        ServiceTodoMailer.new_service_todo_to_technician(@service_todo).deliver_later
        Notification.create(user_id: @service_transaction.car.user_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'created a new task')
         Notification.create(user_id: @service_transaction.staff_in_charge_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'created a new task')
          Notification.create(user_id: @service_transaction.technician_in_charge_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'created a new task')
            if @service_todo.technician_in_charge_id == @service_transaction.technician_in_charge_id

            else
            Notification.create(user_id: @service_todo.technician_in_charge_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'created a new task')
            end
        redirect_to service_transaction_path(@service_transaction), notice: "Service Completed"
        # format.html { redirect_to @service_todo, notice: 'Service todo was successfully created.' }
        # format.json { render :show, status: :created, location: @service_todo }
      else
         
          respond_to do |format|
            format.html { redirect_to service_transaction_path(@service_transaction), notice: "Service Todo Error. Service cant be blank, and Technician in charge cant be blank" }
          end
      end
    else
      redirect_to service_transaction_path(@service_transaction), notice: "Only Admin and Staff Can Add Transaction"
    end

    
  end

  # PATCH/PUT /service_todos/1
  # PATCH/PUT /service_todos/1.json
  # def update
  #   respond_to do |format|
  #     if @service_todo.update(service_todo_params)
  #       format.html { redirect_to @service_todo, notice: 'Service todo was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @service_todo }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @service_todo.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /service_todos/1
  # DELETE /service_todos/1.json
  def destroy
   
    @service_todo.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Service todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


 def completed

    #ServiceTodoMailer.completed(@service_todo).deliver
    if current_user.role.name == "user" || current_user.role.name == "staff"
      redirect_to service_transaction_path(@service_transaction), notice: "Action Denied. Only Technicians and Admins have permission to mark this as on-going."
    else
      #block to check if it is on-going first
      if @service_todo.started_at.blank?
        redirect_to service_transaction_path(@service_transaction), notice: "Please Mark It as On-Going first"
        #end of check block
        #block to check users and staffs from the action
      elsif current_user.role.name == "user" || current_user.role.name == "staff"
        redirect_to service_transaction_path(@service_transaction), notice: "Action Denied.  Only Technicians and Admins have permission to mark this as complete."
      else
        #check if it the user is the admin or the technician in charge
        if current_user.id == @service_todo.technician_in_charge_id || current_user.role.name == "admin"
          @service_todo.update_attribute(:completed_at, Time.now)
           ServiceTodoMailer.completed(@service_todo).deliver_later
           Notification.create(user_id: @service_transaction.car.user_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'completed a task in your transaction.')
            Notification.create(user_id: @service_transaction.staff_in_charge_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'completed a task in your transaction.')
          redirect_to @service_transaction, notice: "Service Completed"
        else
          redirect_to @service_transaction, notice: "Action Denied. Only the Technician-In-Charge and Admins have permission to mark this as complete."
        end
      end
    end
  end   

  def on_going
    
    if current_user.role.name == "user" || current_user.role.name == "staff"
      redirect_to service_transaction_path(@service_transaction), notice: "Action Denied. Only Technicians and Admins have permission to mark this as on-going."


    else
      
      if current_user.id == @service_todo.technician_in_charge_id || current_user.role.name == "admin"
        @service_todo.update_attribute(:started_at, Time.now)
            ServiceTodoMailer.on_going(@service_todo).deliver_later
            Notification.create(user_id: @service_transaction.car.user_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'marked a task in your transaction as on-going.')
            Notification.create(user_id: @service_transaction.staff_in_charge_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'marked a task in your transaction as on-going.')
        redirect_to @service_transaction, notice: "Service On-going"
      else
         redirect_to @service_transaction, notice: "Action Denied. Only the Technician-In-Charge and Admins have permission to mark this as on-going."
      end
    end
  end   

  def paid
    #ServiceTodoMailer.paid(@service_todo).deliver
    @service_todo.update_attribute(:paid_at, Time.now)
    redirect_to @service_transaction, notice: "Service Paid, Please Update the Bill Balance"
  end   

 

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_service_transaction
    @service_transaction = ServiceTransaction.find(params[:service_transaction_id])
  end
    def set_service_todo
      @service_todo = ServiceTodo.find(params[:id])
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def service_todo_params
      params.require(:service_todo).permit(:paid_at, :completed_at, :started_at, :service_transaction_id, :service_id, :technician_in_charge_id)
    end
end
