require "application_system_test_case"

class PatientesTest < ApplicationSystemTestCase
  setup do
    @patiente = patientes(:one)
  end

  test "visiting the index" do
    visit patientes_url
    assert_selector "h1", text: "Patientes"
  end

  test "creating a Patiente" do
    visit patientes_url
    click_on "New Patiente"

    fill_in "Name", with: @patiente.name
    fill_in "Phone", with: @patiente.phone
    fill_in "Surname", with: @patiente.surname
    click_on "Create Patiente"

    assert_text "Patiente was successfully created"
    click_on "Back"
  end

  test "updating a Patiente" do
    visit patientes_url
    click_on "Edit", match: :first

    fill_in "Name", with: @patiente.name
    fill_in "Phone", with: @patiente.phone
    fill_in "Surname", with: @patiente.surname
    click_on "Update Patiente"

    assert_text "Patiente was successfully updated"
    click_on "Back"
  end

  test "destroying a Patiente" do
    visit patientes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Patiente was successfully destroyed"
  end
end
