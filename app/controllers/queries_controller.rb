class QueriesController < ApplicationController
  def index
    # get queries from the current user, group them and count them
    @queries = Query.where(user_id: current_user.id).group(:body).order(count: :desc).count
  end
end
