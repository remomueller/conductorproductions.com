require 'test_helper'

class PcControllerTest < ActionDispatch::IntegrationTest
  test 'should get clients' do
    skip
    get pc_clients_path
    assert_response :success
  end

  test 'should get contact' do
    skip
    get pc_contact_path
    assert_response :success
  end

  test 'should get index' do
    skip
    get pc_index_path
    assert_response :success
  end

  test 'should get our work' do
    skip
    get pc_our_work_path
    assert_response :success
  end

  # test 'should get directors' do
  #   get pc_directors_path
  #   assert_response :success
  # end

  test 'should get director christian williams' do
    skip
    get pc_director_christian_williams_path
    assert_response :success
  end

  test 'should get director kamell allaway' do
    skip
    get pc_director_kamell_allaway_path
    assert_response :success
  end

  test 'should get director noah lydiard' do
    skip
    get pc_director_noah_lydiard_path
    assert_response :success
  end

  test 'should get director vladimir minuty' do
    skip
    get pc_director_vladimir_minuty_path
    assert_response :success
  end
end
