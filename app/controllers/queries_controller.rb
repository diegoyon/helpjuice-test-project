class QueriesController < ApplicationController
  def index
    @queries = Query.where(user_id: current_user.id).group(:body).order(count: :desc).count
  end
end
