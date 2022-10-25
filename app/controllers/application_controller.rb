class ApplicationController < ActionController::Base
  before_action :set_cookie

  private

  def set_cookie
    cookies[:uuid] ||= SecureRandom.uuid
  end
end
