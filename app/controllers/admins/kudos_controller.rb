module Admins
  class KudosController < AdminController
    def index
      @kudos = Kudo.all
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      flash[:notice] = if @kudo.destroy
                         'Kudo was deleted successfully'
                       else
                         'Kudo delete failed'
                       end
      redirect_to admins_kudos_path
    end
  end
end
