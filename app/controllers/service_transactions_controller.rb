class ServiceTransactionsController < ApplicationController
  before_action :set_service_transaction, only: [:show, :edit, :update, :destroy, :finished]

  # GET /service_transactions
  # GET /service_transactions.json
  def index
    if current_user.role.name == "user"
      @service_transactions = current_user.service_transactions.paginate(:page => params[:page], :per_page => 10)
    
    else
      
      @service_transactions = ServiceTransaction.all.paginate(:page => params[:page], :per_page => 10)
    end
  end



  # GET /service_transactions/1
  # GET /service_transactions/1.json
  def show
    #disallow users to view what isnt theirs
     if current_user.id == @service_transaction.car.user_id

     elsif current_user.role.name == "admin" || current_user.role.name == "staff"|| current_user.role.name == "technician"
     else
        redirect_to root_path, notice: "You do not have permission to view this."
     end
      @comments = Comment.where(service_transaction_id: @service_transaction)
     @service_todos = ServiceTodo.where(service_transaction_id: @service_transaction)
  end

  # GET /service_transactions/new
  def new
    if current_user.role.name == "admin" || current_user.role.name == "staff"
      @service_transaction = ServiceTransaction.new
    else
      redirect_to service_transactions_path, notice: "You do not have permission to access page"
    end
    #@service_transaction.service_todos.build
  end

  # GET /service_transactions/1/edit
  def edit
  end

  # POST /service_transactions
  # POST /service_transactions.json
  def create
    
    @service_transaction = ServiceTransaction.new(service_transaction_params)

    respond_to do |format|
      if @service_transaction.save
          Notification.create(user_id: @service_transaction.car.user_id,
                          notified_by_id: current_user.id,
                          car_id: @service_transaction.car_id,
                          service_transaction_id: @service_transaction.id,
                          notice_type: 'created a new transaction for you')
         Notification.create(user_id: @service_transaction.technician_in_charge_id,
                          notified_by_id: current_user.id,
                          car_id: @service_transaction.car_id,
                          service_transaction_id: @service_transaction.id,
                          notice_type: 'created a new transaction for you')
          Notification.create(user_id: @service_transaction.staff_in_charge_id,
                          notified_by_id: current_user.id,
                          car_id: @service_transaction.car_id,
                          service_transaction_id: @service_transaction.id,
                          notice_type: 'created a new transaction for you')
        format.html { redirect_to @service_transaction, notice: 'Service transaction was successfully created.' }
        format.json { render :show, status: :created, location: @service_transaction }
      else
        format.html { render :new }
        format.json { render json: @service_transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  def finished
    #mailer =?
    if current_user.role.name == "admin" || current_user.role.name == "staff"
       @service_transaction.update_attribute(:finished_at, Time.now)
      if current_user.id == @service_transaction.staff_in_charge_id || current_user.role.name == "admin"
         ServiceTransactionMailer.finished(@service_transaction).deliver_later
           Notification.create(user_id: @service_transaction.car.user_id,
                            notified_by_id: current_user.id,
                            car_id: @service_transaction.car_id,
                            service_transaction_id: @service_transaction.id,
                            notice_type: 'marked Transaction  as finished')
           redirect_to @service_transaction, notice: "Service Transaction Finished."
        else
          redirect_to @service_transaction, notice: "Action Denied. Only the Technician-In-Charge and Admins have permission to mark this as complete."
        end

    else
      redirect_to @service_transaction, notice: "Action Stopped, Only Admin and Staff can mark this as Finished."
    end
  end  
  # PATCH/PUT /service_transactions/1
  # PATCH/PUT /service_transactions/1.json
  def update
    respond_to do |format|
      if @service_transaction.update(service_transaction_params)
        format.html { redirect_to @service_transaction, notice: 'Service transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_transaction }
      else
        format.html { render :edit }
        format.json { render json: @service_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_transactions/1
  # DELETE /service_transactions/1.json
  def destroy
    @service_transaction.destroy
    respond_to do |format|
      format.html { redirect_to service_transactions_url, notice: 'Service transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def notify_user
       Notification.create(user_id: @service_transaction.car.user_id,
                          notified_by_id: current_user.id,
                          car_id: @service_transaction.car_id,
                          service_transaction_id: @service_transaction.id,
                          notice_type: 'comment')

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_transaction
      @service_transaction = ServiceTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_transaction_params
      params.require(:service_transaction).permit(:started_at, :finished_at, :car_id, :comments, :staff_in_charge_id, :technician_in_charge_id , :service_todos,:service_todos_attributes => [:service_id, :service_name])
    end
end
