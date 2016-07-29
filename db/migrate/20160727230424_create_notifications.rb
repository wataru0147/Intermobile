class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notified_by, index: true, foreign_key: true
      t.references :car, index: true, foreign_key: true
      t.references :service_transaction, index: true, foreign_key: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
