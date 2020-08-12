class Api::V1::ArticlesController < ApplicationController
  def index
    if params['category']
      articles = Article.where(category: params['category'])
    else
      articles = Article.all
    end
    render json: articles, each_serializer: ArticlesIndexSerializer
  rescue
    render json: {message: "Unfortunatly this category doesn't exist."}, status: 422
  end
  
  def show
    article = Article.find(params[:id])
      render json: article, serializer: ArticleShowSerializer
  rescue
      render json: {message: "Unfortunatly the article you were looking for could not be found."}, status: 422
  end

  def create
    article = current_user.articles.create(article_params)

    if article.persisted?
      render json: {message: "Articles successfully created"}
    else 

    end
   
  end

  private 
  def article_params
    params.permit(:title, :lead, :content, :category)
  end
end
