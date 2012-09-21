ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require "active_support/testing/setup_and_teardown"
require "minitest/reporters"
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

# Load support files
Dir["#{File.dirname(__FILE__)}/helpers/**/*.rb"].each { |f| require f }

DatabaseCleaner.strategy = :truncation
class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  def setup
    DatabaseCleaner.clean
  end

end
#MiniTest::Unit::TestCase.add_setup_hook { DatabaseCleaner.clean }

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  before :each do
    DatabaseCleaner.clean
  end

  def ar_log
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL

  include LoginTestHelper
  include ClickTestHelper
  include ResourceTestHelper

  register_spec_type(/integration$/, self)


end

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior

  register_spec_type(/Helper$/, self)
end

Turn.config.format = :outline


