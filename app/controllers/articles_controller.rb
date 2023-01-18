class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles or /articles.json
  def index

    # if there is a query, look for the word in the articles
    if params[:query].present?
      @articles = Article.where('lower(title) LIKE ?', "%#{params[:query].downcase}%")
      @articles |= Article.where('lower(content) LIKE ?', "%#{params[:query].downcase}%")
      @articles |= Article.where('lower(author) LIKE ?', "%#{params[:query].downcase}%")
      # binding.pry                                                                        
      # function to add a query or edit the last query                                                
      create_query(params[:query].downcase, params[:save])
    else
      @articles = Article.all
    end

    @articles = @articles.paginate(page: params[:page], per_page: 5)

    if turbo_frame_request?
      render partial: 'articles', locals: { articles: @articles }
    else
      render :index
    end
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_url, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :author)
  end

  def create_query(query, save)
    # check if the query is more than 1 character long and
    # if one of the conditions defined in the search_bar_controller are met
    return unless query.length >= 1 && save == "true"

    # check if the last query was made within 10 seconds
    # add to the database only if 10 seconds have already passed
    # since the last search
    last_query = Query.where(user_id: current_user.id).last
    if last_query
      return if last_query.created_at - DateTime.now > -10
    end

    Query.create!(body: query, user_id: current_user.id)
  end
end
