class DemoController < ApplicationController

  layout false

  def index
  end

  def hello
    @array = [1, 2, 3, 4, 5] # this is an instance variable
    @id = params['id']
    @page = params[:page]
  end

  def other_hello
    redirect_to(action: 'index')
    # the demo controller is called by default because we are in demo_controller.rb
  end

  # Can also call to be directed to external links
  def lynda
    redirect_to('https://www.lynda.com')
  end

end
