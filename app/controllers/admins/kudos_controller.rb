module Admins
  class KudosController < AdminController
    def index
      @kudos = Kudo.all
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      Kudo.transaction do
        @kudo.destroy!
        @kudo.receiver.number_of_earned_points -= 10
        @kudo.receiver.save!
        flash[:notice] = 'Kudo was deleted successfully'
        redirect_to admins_kudos_path
      end
    rescue ActiveRecord::RecordInvalid
      flash[:notice] = 'Kudo deletion failed'
      redirect_to admins_kudos_path
    end
  end
end
