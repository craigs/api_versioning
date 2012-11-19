require "test_helper"

describe "Posts Integration" do

  before do
    Post.destroy_all
    @posts = create_list(:post, 10)
  end

  after do
    Post.destroy_all
  end

  it "gets posts API with param=v1" do
    response = get(posts_path(:format => :json, :api_version => 'v1'))
    assert response.ok?
    json = JSON.parse(response.body)
    json['posts'].length.must_equal 10
    json['api_version'].must_equal 'v1'
    json['posts'].length.must_equal 10
  end

  it "gets posts API with param=v1_1" do
    response = get(posts_path(:format => :json, :api_version => 'v1_1'))
    assert response.ok?
    json = JSON.parse(response.body)
    json['posts'].length.must_equal 10
    json['api_version'].must_equal 'v1_1'
    json['posts'].length.must_equal 10
  end

  it "gets posts API with empty api_version param" do
    response = get(posts_path(:format => :json))
    assert response.ok?
    json = JSON.parse(response.body)
    json['posts'].length.must_equal 10
    json['api_version'].must_equal 'v1_1'
    json['posts'].length.must_equal 10
  end

  it "gets posts API with header" do
    response = get(posts_path(:format => :json), {}, { 'HTTP_X_API_VERSION' => 'v1' })
    assert response.ok?
    json = JSON.parse(response.body)
    json['posts'].length.must_equal 10
    json['api_version'].must_equal 'v1'
    json['posts'].length.must_equal 10
  end

  it "get an API error " do
    response = get(error_path(:format => :json))
    json = JSON.parse(response.body)
    json['status_code'].must_equal 400
    json['status_description'].must_equal 'Bad Request'
    json['message'].must_equal 'Deliberate Error'
  end

end
