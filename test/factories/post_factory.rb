FactoryGirl.define do

  factory :post do
    name { Forgery::LoremIpsum.words(10) }
    teaser { Forgery::LoremIpsum.words(30) }
    content { Forgery::LoremIpsum.paragraphs(5)  }
  end

end