class ArticleShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :lead, :content
end
