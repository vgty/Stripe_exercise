require 'sinatra'
require 'dotenv/load'
require 'stripe'
require 'docx'
require 'pry-byebug'
require 'pdf-reader'
require_relative 'jobs/scan'
require_relative 'jobs/stripe'
require_relative 'jobs/density'

include Density

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  erb :index
end

get '/top100' do
  erb :top100
end

post '/upload' do
  Scan::ALL_WORDS.clear
  Density::DENSITY_X2.clear
  Density::DENSITY_X3.clear
  Density::DENSITY_X4.clear
  Density::DENSITY_X5.clear
  if params['document'][:filename].match(/.docx|.txt|.pdf/)
    @book = Scan.new(params['document'])
    @book.scanner
    @density2_array = density2_array.first(30)
    @density3_array = density3_array.first(30)
    @density4_array = density4_array.first(10)
    @density5_array = density5_array.first(10)
    erb :ready
  else
    @alert = "Le format demandé n'est pas le bon veuillez présenter un fichier .docx .pdf ou .txt s'il vous plait "
    erb :index
  end
end

post '/charge' do  
  Payment.new.order(params[:stripeToken])
  @unique = Scan::ALL_WORDS.keys.count
  @all_words = Scan::ALL_WORDS.values.reduce(:+)
  @score = (@unique.to_f / @all_words * 100).round
  @density2_array = density2_array
  @density3_array = density3_array
  @density4_array = density4_array
  @density5_array = density5_array
  @time_to_read = (@all_words.to_f/300/60).round(2)
  Scan::ALL_WORDS.clear
  Density::DENSITY_X2.clear
  Density::DENSITY_X3.clear
  Density::DENSITY_X4.clear
  Density::DENSITY_X5.clear
  erb :results
end

get '/upload/:filename' do |filename|
  send_file "./files/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end
