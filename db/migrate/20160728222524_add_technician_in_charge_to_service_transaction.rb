class AddTechnicianInChargeToServiceTransaction < ActiveRecord::Migration
  def change
    add_reference :service_transactions, :technician_in_charge, index: true, foreign_key: true
  end
end
