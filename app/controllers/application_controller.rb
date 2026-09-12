class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  helper_method :logged_in?

  def home
    @rooms = Room.ordered
    @tenants = Tenant.active.includes(:room)
    @available_rooms = @rooms.where(status: "ว่าง").count
    @occupied_rooms = @rooms.where(status: "มีผู้พัก").count
    @monthly_income = @rooms.where(status: "มีผู้พัก").sum(&:total_charge)
  end

  private

  def require_login
    return if logged_in? || controller_name == "sessions"

    redirect_to login_path, alert: "กรุณาเข้าสู่ระบบก่อนใช้งาน"
  end

  def logged_in?
    session[:admin_logged_in] == true
  end
end
