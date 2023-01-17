require 'rails_helper'

RSpec.describe '/articles', type: :request do
  before :each do
    @user = User.create(email: 'test@gmail.com', password: 123_456)
    sign_in @user
  end

  let(:valid_attributes) do
    {
      title: 'Test title',
      content: 'Test content',
      author: 'Test author'
    }
  end

  let(:invalid_attributes) do
    {
      title: nil,
      content: 'Test content',
      author: 2
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Article.create! valid_attributes
      get articles_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      article = Article.create! valid_attributes
      get article_url(article)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_article_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      article = Article.create! valid_attributes
      get edit_article_url(article)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Article' do
        expect do
          post articles_url, params: { article: valid_attributes }
        end.to change(Article, :count).by(1)
      end

      it 'redirects to the created article' do
        post articles_url, params: { article: valid_attributes }
        expect(response).to redirect_to(articles_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Article' do
        expect do
          post articles_url, params: { article: invalid_attributes }
        end.to change(Article, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post articles_url, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested article' do
      article = Article.create! valid_attributes
      expect do
        delete article_url(article)
      end.to change(Article, :count).by(-1)
    end

    it 'redirects to the articles list' do
      article = Article.create! valid_attributes
      delete article_url(article)
      expect(response).to redirect_to(articles_url)
    end
  end
end
