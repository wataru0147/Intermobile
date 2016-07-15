class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  
  # GET /cars
  # GET /cars.json
  def index
    if user_signed_in?
       if current_user.role.name == "user"
      @cars = current_user.cars
    else
      @cars = Car.all
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
  end

  # POST /cars
  # POST /cars.json
  def create
    if current_user.role.name == "user"
      @car = current_user.cars.build(car_params)
    else  
      @car = Car.new(car_params)
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
      params.require(:car).permit(:plate_number, :year, :user_id, :car_manufacturer_id, :car_model_id, :edited_by)
    end
end
