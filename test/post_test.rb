require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  # Setup by setting serializers as the responder type
  # Must teardown after this test class runs to reset to default
  setup do
    Daredevil.config.config.responder_type = :serializers
    @params = { params: { format: :json } }
    @post = create(:post)
  end

  teardown do
    Daredevil.config.config.responder_type = :jbuilder
  end

  test 'normal success response' do
    get posts_url, @params
    assert_response :success
  end

  test 'get edit' do
    get edit_post_url(create(:post)), @params
    assert_response :success
  end

  test 'serializer response show' do
    get post_path(@post), @params
    r = JSON.parse(response.body)
    assert r['id'].present?
    assert_equal 'I love ruby a lot', r['title']
    assert_response :success
  end

  test 'custom serializer response show' do
    skip
    PostsController.stubs(:respond_with).with(@post, serializer: KustomPostSerializer)
    get post_path(@post), @params
    r = JSON.parse(response.body)
    refute r['id'].present?
    assert_equal 'I love ruby a lot', r['title']
    assert_response :success
  end

  test 'rescue RecordNotFound' do
    assert_nothing_raised do
      get post_path(Post.last.id + 1), @params
    end

    r = JSON.parse(response.body)
    assert_response :not_found
    assert_equal 404, r['status']
    assert_equal 'Not found', r['message']
    assert_equal 'Post', r['resource']
  end

  test 'rescue ParameterMissing' do
    assert_nothing_raised do
      post posts_path, @params
    end

    r = JSON.parse(response.body)
    assert_equal 422, r['status']
    assert_equal 'Missing Parameter', r['message']
    assert_equal 'post', r['resource']
    assert_equal 'Please supply the post param', r['detail']
  end

  test 'post create with blank attribute' do
    @post = attributes_for(:post, title: nil)
    post posts_path, params: { post: @post, format: :json }
    assert_response :unprocessable_entity

    r = JSON.parse(response.body)
    assert_equal 422, r['status']
    assert_equal 'Invalid Attribute', r['message']
    assert_equal 1, r['errors'].size
    assert_equal 'Post', r['errors'][0]['resource']
    assert_equal 'title', r['errors'][0]['field']
    assert_equal 'can\'t be blank', r['errors'][0]['reason']
    assert_equal 'Title can\'t be blank', r['errors'][0]['detail']
  end
end
