class ServiceTodosController < ApplicationController
  
  before_action :set_service_todo , only: [:show, :edit, :update, :destroy]
  # GET /service_todos
  # GET /service_todos.json
  
  # GET /service_todos/new
  def new
    @service_todo = ServiceTodo.new
  end

  # GET /service_todos/1/edit
  def edit
  end

  # POST /service_todos
  # POST /service_todos.json
  def create
    @service_transaction = ServiceTransaction.find(params[:service_transaction_id])
    @service_todo = ServiceTodo.new(service_todo_params)
    @service_todo = ServiceTodo.create(params[:service_todo].permit(:service_id))
    @service_todo.service_transaction_id = @service_transaction.id

  
      if @service_todo.save
        redirect_to service_transaction_path(@service_transaction)
        # format.html { redirect_to @service_todo, notice: 'Service todo was successfully created.' }
        # format.json { render :show, status: :created, location: @service_todo }
      else
        format.html { render :new }
        format.json { render json: @service_todo.errors, status: :unprocessable_entity }
      end
    
  end

  # PATCH/PUT /service_todos/1
  # PATCH/PUT /service_todos/1.json
  def update
    respond_to do |format|
      if @service_todo.update(service_todo_params)
        format.html { redirect_to @service_todo, notice: 'Service todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_todo }
      else
        format.html { render :edit }
        format.json { render json: @service_todo.errors, status: :unprocessable_entity }
      end
    end
  end

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
    @service_todo.update_attribute(:completed_at, Time.now)
    redirect_to @cars_todo_list, notice: "Service Completed"
  end   

  def on_going
    #ServiceTodoMailer.on_going(@service_todo).deliver
    @service_todo.update_attribute(:started_at, Time.now)
    redirect_to @cars_todo_list, notice: "Service On-going"
  end   

  def paid
    #ServiceTodoMailer.paid(@service_todo).deliver
    @service_todo.update_attribute(:paid_at, Time.now)
    redirect_to @cars_todo_list, notice: "Service Paid, Please Update the Bill Balance"
  end   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_todo
      @service_todo = ServiceTodo.find(params[:id])
    end

    # # Never trust parameters from the scary internet, only allow the white list through.
    def service_todo_params
      params.require(:service_todo).permit(:paid_at, :completed_at, :started_at, :service_transaction_id, :service_id)
    end
end
