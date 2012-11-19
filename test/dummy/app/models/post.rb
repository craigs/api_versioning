class Post < ActiveRecord::Base
  attr_accessible :content, :name, :teaser
end
