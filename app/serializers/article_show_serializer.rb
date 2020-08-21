class ArticleShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper
  attributes :id, :title, :lead, :content, :category, :image
  
  def image
    return nil unless object.image.attached?
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      object.image.service_url(expires_in:1.hour, disposition: 'inline')
    end
  end

  def content
    unless object.premium 
      object.content
    else
      if current_user.nil? || !current_user.subscriber?
        truncate(object.content, length: 50)
      else
        object.content
      end
    end
  end
end
