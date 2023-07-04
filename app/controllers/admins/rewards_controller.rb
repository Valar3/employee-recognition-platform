module Admins
  class RewardsController < AdminController
    def index
      render :index, locals: { rewards: Reward.paginate(page: params[:page], per_page: 10) }
    end

    def edit
      render :edit, locals: { reward: Reward.find(params[:id]) }
    end

    def destroy
      @reward = Reward.find(params[:id])
      flash[:notice] = if @reward.destroy
                         'Reward was deleted successfully'
                       else
                         'Reward deletion failed'
                       end
      redirect_to admins_rewards_path
    end

    def update
      reward = Reward.find(params[:id])
      if reward.update(reward_params)
        flash[:notice] = 'Reward was edited successfully'
        redirect_to admins_rewards_path
      else
        render :edit, locals: { reward: }
      end
    end

    def new
      render :new, locals: { reward: Reward.new }
    end

    def create
      reward = Reward.new(reward_params)
      if reward.save!
        flash[:notice] = 'Reward was created successfully'
        redirect_to admins_rewards_path
      else
        render :new, locals: { reward: }
      end
    end

    def import
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
      return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

      ImportCsvService.new.call(params[:file])

      redirect_to request.referer, notice: 'Import started...'
    end

    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_id, :image)
    end
  end
end
