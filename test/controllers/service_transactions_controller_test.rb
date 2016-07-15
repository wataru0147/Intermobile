require 'test_helper'

class ServiceTransactionsControllerTest < ActionController::TestCase
  setup do
    @service_transaction = service_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_transaction" do
    assert_difference('ServiceTransaction.count') do
      post :create, service_transaction: { cars_id: @service_transaction.cars_id, finished_at: @service_transaction.finished_at, started_at: @service_transaction.started_at }
    end

    assert_redirected_to service_transaction_path(assigns(:service_transaction))
  end

  test "should show service_transaction" do
    get :show, id: @service_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_transaction
    assert_response :success
  end

  test "should update service_transaction" do
    patch :update, id: @service_transaction, service_transaction: { cars_id: @service_transaction.cars_id, finished_at: @service_transaction.finished_at, started_at: @service_transaction.started_at }
    assert_redirected_to service_transaction_path(assigns(:service_transaction))
  end

  test "should destroy service_transaction" do
    assert_difference('ServiceTransaction.count', -1) do
      delete :destroy, id: @service_transaction
    end

    assert_redirected_to service_transactions_path
  end
end
