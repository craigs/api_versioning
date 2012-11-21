ApiVersioning
=============

Model based API versioning. Extracted from [launch.ly](http://launch.ly).

[![Build Status](https://travis-ci.org/craigs/api_versioning.png)](https://travis-ci.org/craigs/api_versioning)


Installation
------------

Add this line to your application's Gemfile:

    gem 'api_versioning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_versioning    


Setting up an API model (presenter)
===================================

Let's create a model that will present our API response.

Under your models directory, create a folder called api.
Create your model that will handle API Responses in that api_folder, for example posts_api.rb.

```
class Api::PostsApi < Api::BaseApi

	def v1(posts)

		Jbuilder.encode do |json|
			json.awesome_response 'Hello World'
		end

	end

end
```

Now if I wanted to add a new API version, I would do something like this

```
class Api::PostsApi < Api::BaseApi

	def v1(posts)

		Jbuilder.encode do |json|
			json.awesome_response 'Hello World'
		end

	end

	def v1_1(posts)

		Jbuilder.encode do |json|
			json.posts items do |json, post|
				timestamps json, post
				json.post post.title
			end
		end

	end

end
```

I used DHH [JBuilder](https://github.com/rails/jbuilder) to format out the JSON responses, but you can use whatever you like.

Setting up your Controller
==========================

There is a method called render_json that accepts the collections that you would like rendered as an API response. Here is a sample implementation:

```
class PostsController < ApplicationController

	def index

		@posts = Post.all
      
		respond_to do |format|
			format.json { render_json posts: @posts }
		end

	end

end
```

Requesting an API Version
=========================

### About API Version Numbers

We have adopted API version numbers that consist of a major and minor API version number. The major and minor API version number consists of digits 0-9 and are spearated by an underscore. For example, 1_2 refers to API version 1.2

if an API version number is not detected, the latest version is used.

### Requesting an API Version by Request Header

```
curl -H "X-Api-Version:v1_2" http://localhost/posts.json
```

### Requesting an API Version by Query String Parameter

Just add the api_version parameter to your request's query string like this

```
http://localhost/posts.json?api_version=v1_2
````

### Order of Precedence

If you request API versions via multiple methods, the following order of precedence will apply:

1. Request Parameter params['api_version']
2. Request Header HTTP_X_API_VERSION

# Building locally

bundle exec rake -f test/dummy/Rakefile db:migrate db:test:prepare
rake

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
