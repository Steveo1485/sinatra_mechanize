require 'sinatra'
require 'haml'

set :server, 'webrick'

require_relative 'models/gumtree_scrapper'

get '/' do
  @test = "what"
  haml :index
end

get '/results' do
  scrapper = GumtreeScrapper.new(params[:service], params[:terms], params[:postal_code])
  @results = scrapper.scrape
  haml :results
end