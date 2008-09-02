require 'test_helper'

class SubRegionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_regions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sub_region
    assert_difference('SubRegion.count') do
      post :create, :sub_region => { }
    end

    assert_redirected_to sub_region_path(assigns(:sub_region))
  end

  def test_should_show_sub_region
    get :show, :id => sub_regions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => sub_regions(:one).id
    assert_response :success
  end

  def test_should_update_sub_region
    put :update, :id => sub_regions(:one).id, :sub_region => { }
    assert_redirected_to sub_region_path(assigns(:sub_region))
  end

  def test_should_destroy_sub_region
    assert_difference('SubRegion.count', -1) do
      delete :destroy, :id => sub_regions(:one).id
    end

    assert_redirected_to sub_regions_path
  end
end
