class Api::V1::ArticlesController < ApplicationController
  def index
    if params['category'].nil?
      articles = Article.all
    else
      articles = Article.where(category: params['category'])
    end
    render json: articles, each_serializer: ArticlesIndexSerializer
  end
  
  def show
    article = Article.find(params[:id])
      render json: article, serializer: ArticleShowSerializer
  rescue
      render json: {message: "Unfortunatly the article you were looking for could not be found."}, status: 422
  end
end
