json.array!(@service_transactions) do |service_transaction|
  json.extract! service_transaction, :id, :started_at, :finished_at, :cars_id
  json.url service_transaction_url(service_transaction, format: :json)
end
