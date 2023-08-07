module Admins
  class RewardsController < AdminController
    def index
      render :index, locals: { rewards: Reward.includes(%i[category image_attachment]).paginate(page: params[:page], per_page: 10) }
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
      reward= Reward.new
      reward.online_codes.build
      render :new, locals: { reward: reward }

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

    def import_online_codes; end

    def import
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?

      unless params[:file].content_type == 'text/csv'
        return redirect_to request.referer,
                           notice: 'Only CSV files allowed'
      end

      ImportCsvService.new.call(params[:file])
      redirect_to request.referer, notice: 'Import completed'
    rescue StandardError => e

    end
    def generate_code
      online_codes = generate_online_codes(params[:reward][:available_rewards].to_i, 5)
      respond_to do |format|
        format.js
      end
    end
    private

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :category_id, :image, :delivery_method, :available_rewards, online_codes_attributes:[:code, :used, :id, :_destroy])
    end

    def generate_online_code(length)
      characters = (0..9).to_a
      code = Array.new(length) { characters.sample }.join
    end
  end
end
