require 'test_helper'

class ServiceTodosControllerTest < ActionController::TestCase
  setup do
    @service_todo = service_todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_todo" do
    assert_difference('ServiceTodo.count') do
      post :create, service_todo: { completed_at: @service_todo.completed_at, paid_at: @service_todo.paid_at, service_transaction_id: @service_todo.service_transaction_id, started_at: @service_todo.started_at }
    end

    assert_redirected_to service_todo_path(assigns(:service_todo))
  end

  test "should show service_todo" do
    get :show, id: @service_todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_todo
    assert_response :success
  end

  test "should update service_todo" do
    patch :update, id: @service_todo, service_todo: { completed_at: @service_todo.completed_at, paid_at: @service_todo.paid_at, service_transaction_id: @service_todo.service_transaction_id, started_at: @service_todo.started_at }
    assert_redirected_to service_todo_path(assigns(:service_todo))
  end

  test "should destroy service_todo" do
    assert_difference('ServiceTodo.count', -1) do
      delete :destroy, id: @service_todo
    end

    assert_redirected_to service_todos_path
  end
end
