class PostsController < ApplicationController

	def index

		@posts = Post.all
      
		respond_to do |format|
			format.json { render_json posts: @posts }
		end

	end

	def error
		respond_to do |format|
			format.json { render_api_error('Deliberate Error') }
		end
	end

end
