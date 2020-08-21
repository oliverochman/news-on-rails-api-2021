class Api::V1::ArticlesController < ApplicationController

  def index
    if params['category']
      articles = Article.where(category: params['category'], published: true)
    elsif params['longitude'] && params['latitude']
      location = Geocoder.search([params['latitude'], params['longitude']])
      articles = Article.where(location: location.first.country, published: true)
    else
      articles = Article.all.where(published: true)
    end
    render json: articles, each_serializer: ArticlesIndexSerializer
  rescue
    render json: {message: "Oops, Something went wrong."}, status: 422
  end
  
  def show
    article = Article.find(params[:id])
      
    render json: article, serializer: ArticleShowSerializer
  rescue
      render json: {message: "Unfortunatly the article you were looking for could not be found."}, status: 422
  end
end