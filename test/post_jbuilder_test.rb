require 'test_helper'

class PostJbuilderTest < ActionDispatch::IntegrationTest
  setup do
    @post = create(:post)
    @params = { params: { format: :json } }
  end

  test 'normal success response' do
    get posts_url, @params
    r = JSON.parse(response.body)
    assert r.is_a?(Array)

    sample = r.first
    assert sample['id'].present?
    assert_equal 'I love ruby a lot', sample['title']
    assert_response :success
  end

  test 'show response' do
    get post_path(@post), @params
    r = JSON.parse(response.body)
    assert r['id'].present?
    assert_equal 'I love ruby a lot', r['title']
    assert_response :success
  end
end
