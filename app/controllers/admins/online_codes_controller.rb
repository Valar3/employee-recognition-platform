module Admins
  class OnlineCodesController < AdminController
    def index
      online_codes = OnlineCode.all
      render :index, locals: { online_codes: online_codes }
    end

    def new
      online_code = OnlineCode.new
      render :new, locals: { online_code: online_code }
    end

    def import_online_codes
      return redirect_to request.referer, notice: 'No file added' if params[:file].nil?

      unless params[:file].content_type == 'text/csv'
        return redirect_to request.referer,
                           notice: 'Only CSV files allowed'
      end

      ImportOnlineCode.new.call(params[:file])
      redirect_to request.referer, notice: 'Import completed'
    rescue StandardError => e
      redirect_to request.referer , notice: e.message
    end

    def create
      online_code = OnlineCode.new(online_code_params)
      if online_code.save
        redirect_to admins_online_codes_path, notice: 'Online code created'
      else
        render :new, locals: { online_code: online_code }
        flash[:alert] = 'Online code not created'
      end
    end

    private

    def online_code_params
      params.require(:online_code).permit(:code, :reward_id, :used)
    end
  end
end
