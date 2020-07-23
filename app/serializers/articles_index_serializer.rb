class ArticlesIndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :lead, :content
end
