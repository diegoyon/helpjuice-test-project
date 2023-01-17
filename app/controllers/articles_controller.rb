class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  require 'string/similarity'
  # GET /articles or /articles.json
  def index
    # @articles = Article.all

    if params[:query].present?
      @articles = Article.where("lower(title) LIKE ?", "%#{params[:query].downcase}%") + Article.where("lower(content) LIKE ?", "%#{params[:query].downcase}%") + Article.where("lower(author) LIKE ?", "%#{params[:query].downcase}%")
      create_query(params[:query]);
    else
      @articles = Article.all
    end

    if turbo_frame_request?
      render partial: "articles", locals: { articles: @articles }
    else
      render :index
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
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
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
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
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
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

    def create_query(query)
      return unless query.length >= 3
      if Query.last
        last_query = Query.last
      else
        last_query = Query.create!(body: query, user_id: current_user.id)
      end
      similarity = String::Similarity.cosine last_query.body, query
      if similarity > 0.7
        last_query.update(body: query)
      else
        Query.create!(body: query, user_id: current_user.id)
      end
    end
end
