class AddTechnicianIdAndStaffIdToServiceTransaction < ActiveRecord::Migration
  def change
    add_reference :service_todos, :technician_in_charge, index: true, foreign_key: true
    add_reference :service_transactions, :staff_in_charge, index: true, foreign_key: true
  end
end
