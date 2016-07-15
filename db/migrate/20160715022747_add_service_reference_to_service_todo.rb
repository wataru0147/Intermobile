class AddServiceReferenceToServiceTodo < ActiveRecord::Migration
  def change
    add_reference :service_todos, :service, index: true, foreign_key: true
  end
end
