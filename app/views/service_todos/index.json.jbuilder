json.array!(@service_todos) do |service_todo|
  json.extract! service_todo, :id, :paid_at, :completed_at, :started_at, :service_transaction_id
  json.url service_todo_url(service_todo, format: :json)
end
