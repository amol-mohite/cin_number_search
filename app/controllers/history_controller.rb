class HistoryController < ApplicationController
  before_action :authenticate_user!
  def index
    @histories = current_user.histories.order(searched_at: :desc).paginate(:per_page => 20, :page => params[:page])
  end

  def destroy
    @history = History.find params[:id]
    @history.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  def clear_history
    if request.post?
      if params[:time_period].present?
        where_clause = History.get_where_clause(params[:time_period])
        current_user.histories.where(where_clause).destroy_all
        redirect_to history_index_path
      end
    end
  end
end
