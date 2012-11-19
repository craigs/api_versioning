require 'jbuilder'

class Api::PostsApi < Api::BaseApi

  def v1(posts)

    Jbuilder.encode do |json|

      json.api_version 'v1'
    	
      json.posts posts do |json, post|
        timestamps json, post      
        json.name post.name
        json.content post.content
      end

    end
    
  end

  def v1_1(posts)

    Jbuilder.encode do |json|
      
      json.api_version 'v1_1'

      json.posts posts do |json, post|
        timestamps json, post      
        json.name post.name
        json.teaser post.teaser
        json.content post.content
      end

    end
    
  end

end