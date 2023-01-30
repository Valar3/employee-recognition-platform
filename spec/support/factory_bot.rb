RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

#class Test::Unit::TestCase
 # include FactoryBot::Syntax::Methods
 #end
#Cucumber
# env.rb (Rails example location - RAILS_ROOT/features/support/env.rb)#
#World(FactoryBot::Syntax::Methods)
#Spinach
#class Spinach::FeatureSteps
 # include FactoryBot::Syntax::Methods
#end
#Minitest
#class Minitest::Unit::TestCase
 # include FactoryBot::Syntax::Methods
#end
#Minitest::Spec
#class Minitest::Spec
# include FactoryBot::Syntax::Methods
#end
#minitest-rails
#class ActiveSupport::TestCase
 # include FactoryBot::Syntax::Methods
#end
