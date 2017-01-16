require 'test_helper'

class PcControllerTest < ActionDispatch::IntegrationTest
  test 'should get clients' do
    get pc_clients_path
    assert_response :success
  end

  test 'should get contact' do
    get pc_contact_path
    assert_response :success
  end

  test 'should get directors' do
    get pc_directors_path
    assert_response :success
  end

  test 'should get index' do
    get pc_index_path
    assert_response :success
  end

  test 'should get our work' do
    get pc_our_work_path
    assert_response :success
  end

  test 'should get what we do' do
    get pc_what_we_do_path
    assert_response :success
  end
end
