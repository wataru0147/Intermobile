json.array!(@car_models) do |car_model|
  json.extract! car_model, :id, :name, :car_manufacturer_id
  json.url car_model_url(car_model, format: :json)
end
