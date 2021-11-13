require "test_helper"

class PatientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patiente = patientes(:one)
  end

  test "should get index" do
    get patientes_url
    assert_response :success
  end

  test "should get new" do
    get new_patiente_url
    assert_response :success
  end

  test "should create patiente" do
    assert_difference('Patiente.count') do
      post patientes_url, params: { patiente: { name: @patiente.name, phone: @patiente.phone, surname: @patiente.surname } }
    end

    assert_redirected_to patiente_url(Patiente.last)
  end

  test "should show patiente" do
    get patiente_url(@patiente)
    assert_response :success
  end

  test "should get edit" do
    get edit_patiente_url(@patiente)
    assert_response :success
  end

  test "should update patiente" do
    patch patiente_url(@patiente), params: { patiente: { name: @patiente.name, phone: @patiente.phone, surname: @patiente.surname } }
    assert_redirected_to patiente_url(@patiente)
  end

  test "should destroy patiente" do
    assert_difference('Patiente.count', -1) do
      delete patiente_url(@patiente)
    end

    assert_redirected_to patientes_url
  end
end
