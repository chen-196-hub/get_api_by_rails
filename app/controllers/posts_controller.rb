class PostsController < ApplicationController
  require 'net/https'
  require 'uri'
  require 'json'  
  before_action :get_api,only: %i[index]

  def index
  end

  def show
    @url = "https://docker-rails-apiapp.herokuapp.com/api/v1/posts/#{params[:id]}"
    @uri = URI(@url)
    @response = Net::HTTP.get_response(@uri)
    @output = JSON.parse(@response.body)
    @index = @output["data"]
  end

  def new
    @params = {title:params[:title],content:params[:content]}
    @headers = { "Content-Type" => "application/json" }
    @uri = URI.parse('https://docker-rails-apiapp.herokuapp.com/api/v1/posts')
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = @uri.scheme === "https"
    @response = @http.post(@uri.path, @params.to_json, @headers)
    @response.code# status code
    @response.body
    redirect_to root_path
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  private



  def get_api
    @url = 'https://docker-rails-apiapp.herokuapp.com/api/v1/posts'
    @uri = URI(@url)
    @response = Net::HTTP.get_response(@uri)
    @output = JSON.parse(@response.body)
    @index = @output["data"]
  end
  
end
