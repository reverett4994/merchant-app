require 'test_helper'

class ItemAlbumsControllerTest < ActionController::TestCase
  setup do
    @item_album = item_albums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_album" do
    assert_difference('ItemAlbum.count') do
      post :create, item_album: { item_id: @item_album.item_id }
    end

    assert_redirected_to item_album_path(assigns(:item_album))
  end

  test "should show item_album" do
    get :show, id: @item_album
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_album
    assert_response :success
  end

  test "should update item_album" do
    patch :update, id: @item_album, item_album: { item_id: @item_album.item_id }
    assert_redirected_to item_album_path(assigns(:item_album))
  end

  test "should destroy item_album" do
    assert_difference('ItemAlbum.count', -1) do
      delete :destroy, id: @item_album
    end

    assert_redirected_to item_albums_path
  end
end
