require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'
#require 'sqlite3'

before do
  q = "SELECT DISTINCT genre FROM videos"
  @genres = run_sql(q)
end

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

post '/create' do
  q = "INSERT INTO videos (name, description, url, genre)
        VALUES ('#{params['name']}', '#{params['description']}', '#{params['url']}', '#{params['genre']}')"
        #binding.pry

  run_sql(q)
  redirect to('/videos')
  #binding.pry
end

post '/videos/:id' do
  q = "UPDATE videos SET name='#{params['name']}', description='#{params['description']}', url='#{params['url']}', genre='#{params['genre']}'
  WHERE id=#{params[:id]}"
  run_sql(q)
  redirect to('/videos')
end

get '/videos/:id/edit' do
  q = "SELECT * FROM videos WHERE id=#{params[:id]}"
  rows = run_sql(q)
  @video = rows.first

  erb :new
end

post '/videos/:id/delete' do
  q = "DELETE FROM videos WHERE id=#{params[:id]}"
  run_sql(q)
  redirect to('/videos')
end

get '/videos' do
  q = "SELECT * FROM videos"
  @videos = run_sql(q)
  #binding.pry

  erb :videos
end

get '/videos/:genre' do
  q = "SELECT * FROM videos WHERE genre='#{params[:genre]}'"
  @videos = run_sql(q)

  erb :videos
end


def run_sql(query)
  conn = PG.connect(:dbname => 'allvideos', :host => 'localhost')
  result = conn.exec(query)
  conn.close

  result
end


=begin
def run_sql(query)
  conn = PG.connect(:dbname => 'allvideos', :host => 'localhost', :user => 'hui', :password => 'password' )
  result = conn.exec(query)
  conn.close

  result
end
=end

=begin
def run_sql(sql)
  conn = PG.connect(:dbname =>'tubedb', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end
=end