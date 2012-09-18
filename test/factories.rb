require 'factory_girl'

FactoryGirl.define do
  factory :library do
    user
    sequence(:name) {|n| "library #{n}" }
    sequence(:host) {|n| "library#{n}.booklibrarying.cc" }
    description { "#{name} description" }
    slogan { "#{name} slogan" }
    question { "#{name} question" }
  end

  factory :license do
    name 'CreativeCommons'
  end

  factory :user do
    sequence(:name) {|n| "user#{n}" } 
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { "#{name}-secret"}
  end

  factory :reference do
    user
    library
    license
    sequence(:title) {|n| "Reference #{n}" }
    authors { "#{title} authors" }
    editor { "#{title} editor" }
    description { "#{title} description" }
    date { "#{title} date" }

    ref_type 'Book'
  end

  factory :version do
    event 'create'
    whodunnit '1'
    title 'title'
    user_name 'user'
    processed false
  end


  factory :shelf do
    library
    user 
    sequence(:name) {|n| "Shelf #{n}"}
    description { "#{name} description" }
    sequence(:slug) {|n| "Shelf slug #{n}"}
  end

  factory :tag do
    sequence(:name) {|n| "Tag#{n}" }
  end

  factory :taggin do
    tag
    association :reference, factory: :reference
    user
  end
end
