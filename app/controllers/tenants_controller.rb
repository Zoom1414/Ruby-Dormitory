class TenantsController < ApplicationController
  def index
    @tenants = Tenant.active.includes(:room)
    @former_tenants = Tenant.where.not(moved_out_at: nil).includes(:room).order(moved_out_at: :desc)
  end

    def new
      @tenant = Tenant.new
      @rooms = Room.ordered
    end
  
  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      redirect_to tenants_path, notice: "เพิ่มผู้พักอาศัยเรียบร้อยแล้ว"
    else
      @rooms = Room.ordered
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    tenant = Tenant.active.find(params[:id])
    room_number = tenant.room.room_number
    tenant.update!(moved_out_at: Time.current)
    redirect_to tenants_path, notice: "แจ้งผู้พักห้อง #{room_number} ออกเรียบร้อยแล้ว ห้องกลับเป็นห้องว่าง"
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :phone, :id_card, :room_id)
  end
end
