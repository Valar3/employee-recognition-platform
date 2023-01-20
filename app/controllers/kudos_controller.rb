class KudosController < ApplicationController
  def index
    @kudos = Kudo.all
  end

  def new
    @kudo = Kudo.new
  end

  def create
    @kudo.empolyee = current_employee
      if @kudo.save
        flash[:notice] = "Kudo was created successfully"
        redirect_to kudos
      else
        render 'new'
      end
  end
      private

      def kudo_params
        params.require(:kudo).permit(:Title, :Content, :giver_id, :receiver_id )
      end
end
