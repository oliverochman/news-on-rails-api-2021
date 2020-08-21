FactoryBot.define do
  factory :article do
    premium { false }
    title { "MyString" }
    lead { "MyText" } 
    content { "MyText" }
    category { 1 }
    published { true }
    location { 'Sweden' }
    association :journalist, factory: :user
  end
end
