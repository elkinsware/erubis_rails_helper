class WelcomeController < ApplicationController
  def index
    @test_model = TestModel.new
  end

end
