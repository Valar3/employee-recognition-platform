class KudosController < ApplicationController

  def show
    @kudo = Kudo.find(params[:id])
  end

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

  def update
    @kudo = Kudo.find(params[:id])
    if @kudo.update(kudo_params)
      flash[:notice] = 'Kudo was edited successfully'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      redirect_to root_path
  end
  private

  def kudo_params
    params.require(:kudo).permit(:Title, :Content, :giver_id, :receiver_id)
  end
end
