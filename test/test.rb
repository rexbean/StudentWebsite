require "dm-core"
require "dm-migrations" #Dir.pwd is class method of Dir

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/test.db" )


class Test
  include DataMapper::Resource
  property :id, Serial
  property :firstname, String, required: true
  property :lastname, String, required: true
  # property :birthday, Date
  property :address, String
  property :student_id, String
  property :create_at, DateTime, required: true
  DataMapper.finalize
  DataMapper.auto_migrate!
  # def initialize(params)
  #   @data = {}
  #   @data[:firstname] = params[:firstname]
  #   @data[:lastname] = params[:lastname]
  #   @data[:address] = params[:address]
  #   birthday = params[:birthday].to_s =~ /^\d\d\d\d-\d\d?-\d\d?$/ ? params[:birthday] : ""
  #   @data[:birthday] = birthday
  #   @data[:student_id] = params[:student_id]
  # end
  attr_accessor :data

  def check()
    result = true
    result = false if @data[:firstname].to_s.empty? || @data[:lastname].to_s.empty?
    return result
  end

  def getInfo()
    @data
    puts 'a'
    puts @data
    puts 'b'
    return @data
  end

end
