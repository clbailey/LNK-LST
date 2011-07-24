require 'rubygems'
require 'sinatra'
require 'erb'
require 'redis'

redis = Redis.new

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  def random_string(length)
    rand(36**length).to_s(36)
  end
end

get '/' do
  erb :index
end

post '/' do
  if params[:url] and params[:title] and not params[:url].empty? and not params[:title].empty?
    @shortcode = random_string 5
    redis.hset "links:#{@shortcode}", params[:title], params[:url]
  end
  erb :index
end

get '/:shortcode' do
  @hashurl = redis.hgetall "links:#{params[:shortcode]}"
  erb :list
end

