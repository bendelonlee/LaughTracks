# require_relative "../models/comedian"
class LaughTracksApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/comedians' do
    comedian_payload = Comedian.fetch_data(params)
    special_payload = Special.fetch_data(params)
    @comedians = comedian_payload[:comedians]
    @cities = comedian_payload[:cities]
    @average_age = comedian_payload[:average_age]
    @average_runtime = special_payload[:average_runtime]
    @total_specials = special_payload[:total_specials]
    @all_comedian_ages = Comedian.pluck(:age)
    erb :index_vinyl
  end

  get '/comedians/new' do
    erb :new
  end

  post '/comedians' do #Would /create_comedian  or non-plural /comedian be okay, or is it not RESTful/against convention?
    Comedian.create(params[:comedian])
    redirect '/comedians'
  end

end
