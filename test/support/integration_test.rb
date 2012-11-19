class IntegrationTest < MiniTest::Spec

  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers
#  include ActiveSupport::Testing::SetupAndTeardown

  def app
    DUMMY_APP
  end

  register_spec_type(/integration$/i, self)

end
