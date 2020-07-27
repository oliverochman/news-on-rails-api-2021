FactoryBot.define do
  factory :article do
    title { "MyString" }
    lead { "MyText" } 
    content { "MyText" }
    category { 1 }
  end
end
