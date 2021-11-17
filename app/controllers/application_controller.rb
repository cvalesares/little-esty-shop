class ApplicationController < ActionController::Base
  before_action :api_call

  def api_call
    @holidays = HolidaySearch.new
  end
end
