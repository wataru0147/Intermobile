class ServiceTransactionsController < ApplicationController
  before_action :set_service_transaction, only: [:show, :edit, :update, :destroy]

  # GET /service_transactions
  # GET /service_transactions.json
  def index
    @service_transactions = ServiceTransaction.all
  end

  # GET /service_transactions/1
  # GET /service_transactions/1.json
  def show
     @comments = Comment.where(service_transaction_id: @service_transaction)
     @service_todos = ServiceTodo.where(service_transaction_id: @service_transaction)
  end

  # GET /service_transactions/new
  def new
    @service_transaction = ServiceTransaction.new
    @service_transaction.service_todos.build
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
        format.html { redirect_to @service_transaction, notice: 'Service transaction was successfully created.' }
        format.json { render :show, status: :created, location: @service_transaction }
      else
        format.html { render :new }
        format.json { render json: @service_transaction.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_transaction
      @service_transaction = ServiceTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_transaction_params
      params.require(:service_transaction).permit(:started_at, :finished_at, :car_id, :comments, :service_todos,:service_todos_attributes => [:service_id, :service_name])
    end
end
