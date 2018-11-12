require 'sinatra'
require 'dm-core'
require 'dm-timestamps'
require 'dm-migrations'

require './Student'
require './Comment'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, development? ? "sqlite3://#{Dir.pwd}/info.db" : ENV['DATABASE_URL'])
DataMapper.finalize
DataMapper.auto_migrate!


configure do
  enable :sessions
end

get '/' do
  @content = 'this is hello world!!!'
  erb :index
end

# here for the administrator
# get login page
get '/login' do
  @message = "username is admin, password is password, thanks"
  erb :login
end

# login
post '/login' do
  if params[:username].to_s != 'admin' &&
    params[:password].to_s != 'password'
      @message = 'login failed'
      redirect '/login'
  else
    session[:login] = true
    redirect '/'
  end
end

# logout
get '/logout' do
  session.clear
  redirect '/'
end

# Here for the student
# show all students
get '/student' do
  @students = Student.all
  erb :student_list
end

# add student webpage
get '/student/new' do
  redirect '/login' unless session[:login]
  @student = Student.new
  erb :student_input
end

# add student
post '/student/new' do
  redirect '/login' unless session[:login]
  student = Student.new
  student.data = params
  redirect '/student/new?result=valid%20Data' unless student.check
  a = student.getInfo
  Student.create(a)
  redirect '/student'
end

# show student detail
get '/student/:id' do |id|
  @student = Student.get(id)
  erb :student_detail
end

# edit student info
get '/student/:id/edit' do |id|
  redirect '/login' unless session[:login]
  @student = Student.get(id)
  erb :student_input
end

# get the updated info
post '/student/:id/edit' do |id|
  redirect '/login' unless session[:login]
  student = Student.get(id)
  student.data = params
  redirect '/student/new?result=valid%20Data' unless student.check
  a = student.getInfo
  student.update(a)
  redirect '/student'
end

# delete student info
get '/student/:id/delete' do |id|
  redirect '/login' unless session[:login]
  Student.get(id)&.destroy
  redirect '/student'
end

# here for the comment
# show comments
get '/comment' do
  @comments = Comment.all
  erb :comment_list
end

# add comment page
get '/comment/new' do
  @comment = Comment.new
  redirect '/login' unless session[:login]
  erb :comment_input
end

# add comment
post '/comment/new' do
  redirect '/login' unless session[:login]
  comment = Comment.new
  comment.data = params
  redirect '/comment/new?result=valid%20Data' unless comment.check
  a = comment.getInfo
  Comment.create(a)
  redirect '/comment'
end

# show comment detail
get '/comment/:id' do |id|
  redirect '/login' unless session[:login]
  @comment = Comment.get(id)
  erb :comment_detail
end


# edit student info
get '/comment/:id/edit' do |id|
  redirect '/login' unless session[:login]
  @comment = Comment.get(id)
  erb :comment_input
end

# edit
post '/comment/:id/edit' do |id|
  redirect '/login' unless session[:login]
  comment = Comment.get(id)
  comment.data = params
  redirect '/comment/new?result=valid%20Data' unless comment.check
  a = comment.getInfo
  comment.update(a)
  redirect '/comment'
end

# show video
get '/video' do
  erb :video
end

get '/*' do
  erb :index
end
