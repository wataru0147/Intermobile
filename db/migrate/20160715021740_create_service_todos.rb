class CreateServiceTodos < ActiveRecord::Migration
  def change
    create_table :service_todos do |t|
      t.datetime :paid_at
      t.datetime :completed_at
      t.datetime :started_at
      t.references :service_transaction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
