class Api::V1::Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_journalist, only: [:create]
  before_action :authorize_editor, only: [:update]
  
  def index
    if current_user.role == 'editor'
      articles = Article.all.where(published: false)
      render json: articles, each_serializer: ArticlesEditorIndexSerializer
    elsif current_user.role == 'journalist'
      articles = current_user.articles
      render json: articles, each_serializer: ArticlesJournalistIndexSerializer
    else
      unauthorized
    end
  end

  def create
    article = current_user.articles.create(article_params)
      if article.persisted? && attach_image(article)
        render json: {message: "Article successfully created"}
      else 
        render_error_message(article.errors)
    end
  end
    
  def update 
    article = Article.find(params[:id])
    if article.published?
      render json: {message: "This article has already been published."}, status: 422
    else
      article.update(article_params)
      render json: {message: "The article was successfully published!"}
    end
  end 
    
  private 
    
  def article_params
    params.require(:article).permit(:location, :premium, :title, :lead, :content, :category, :published)
  end
    
  def authorize_journalist
    unless current_user.role =='journalist'
      unauthorized
    end
  end
    
  def authorize_editor
    unless current_user.role == 'editor'
      unauthorized
    end
  end
    
  def unauthorized
    render json: {message: 'You are not authorized to access this action'}, status: 401
  end
    
  def attach_image(article)
    params_image = params[:article][:image]
      if params_image.present?
        DecodeService.attach_image(params_image, article.image)
    end
  end
end