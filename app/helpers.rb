# Helper methods defined here can be accessed in any controller or view in the application

# Unclejosh.helpers do

module UnclejoshHelper
  def simple_helper_method
    'helper'
  end
end

Unclejosh.helpers UnclejoshHelper
