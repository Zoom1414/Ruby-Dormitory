class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
  end

  def create
    if valid_credentials?
      session[:admin_logged_in] = true
      redirect_to root_path, notice: "ยินดีต้อนรับกลับเข้าสู่ระบบ"
    else
      flash.now[:alert] = "อีเมลหรือรหัสผ่านไม่ถูกต้อง"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "ออกจากระบบเรียบร้อยแล้ว"
  end

  private

  def valid_credentials?
    email = Digest::SHA256.hexdigest(params[:email].to_s)
    expected_email = Digest::SHA256.hexdigest(ENV.fetch("DORMITORY_ADMIN_EMAIL", "admin@dormitory.local"))
    password = Digest::SHA256.hexdigest(params[:password].to_s)
    expected_password = Digest::SHA256.hexdigest(ENV.fetch("DORMITORY_ADMIN_PASSWORD", "dormitory123"))
    ActiveSupport::SecurityUtils.secure_compare(email, expected_email) && ActiveSupport::SecurityUtils.secure_compare(password, expected_password)
  end
end