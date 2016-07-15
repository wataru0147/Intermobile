class CreateServiceTransactions < ActiveRecord::Migration
  def change
    create_table :service_transactions do |t|
      t.datetime :started_at, default: nil
      t.datetime :finished_at, default: nil
      t.references :car, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
