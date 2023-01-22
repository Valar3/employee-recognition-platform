class KudosController < ApplicationController
  def index
    @kudos = Kudo.all
  end

  def new
    @kudo = Kudo.new
  end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver_id = current_employee.id
    if @kudo.save
      flash[:notice] = 'Kudo was created successfully'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def kudo_params
    params.require(:kudo).permit(:Title, :Content, :giver_id, :receiver_id)
  end
end
