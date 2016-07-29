class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  
  # GET /cars
  # GET /cars.json
  def index
    if user_signed_in?
       if current_user.role.name == "user"
      @cars = current_user.cars.where(["plate_number LIKE ?", "%#{params[:search]}%"]).paginate(:page => params[:page], :per_page => 10)
      else
        @cars = Car.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      end
    else
      redirect_to new_user_session_path
    end
   
  end

  # GET /cars/1
  # GET /cars/1.json
  def show

  	# u = User.where(:id => @car.edited_by)
    @service_transactions = ServiceTransaction.where(car_id: @car)
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
    if current_user.role.name == "technician"
      redirect_to root_path, notice: "Action Denied. You do not have permission to edit this"
    end
  end

  # POST /cars
  # POST /cars.json
  def create
    if current_user.role.name == "user"
      redirect_to root_path
      #@car = current_user.cars.build(car_params)
    elsif current_user.role.name == "admin" || current_user.role.name == "staff"
      @car = Car.new(car_params)
    else
       redirect_to root_path
    end 
    #@car.edited_by = current_user.id
    respond_to do |format|
      if @car.save
      	
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
  	 if current_user.role.name == "technician"
      redirect_to root_path, notice: "Action Denied. You do not have permission to edit this"
    end
  	#@car.edited_by = current_user.id
    respond_to do |format|
      if @car.update(car_params)
      	
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.



    def set_car
      @car = Car.find(params[:id])
    end


     

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:plate_number, :year, :user_id, :car_manufacturer_id, :car_model_id, :edited_by, :picture)
    end
end
