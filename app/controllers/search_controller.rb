class SearchController < ApplicationController
  before_action :authenticate_user!
  def search_cin_number
  	@cin_data_hash = {}
  	@histories = current_user.histories.order(searched_at: :desc).paginate(:per_page => 10, :page => params[:page])
  	if request.post?
	  	if params[:cin_number].present?
	  		@history = History.new(user: current_user)
	  		@history.cin_number = params[:cin_number]
	  		@history.searched_at = Time.now
	  		@history.save
	  		@cin_data_hash = get_cin_data_hash(params[:cin_number])
	  	else
	  		@cin_data_hash = {error: 'Please Enter CIN Number'}
	  	end
  	end
  end
end
