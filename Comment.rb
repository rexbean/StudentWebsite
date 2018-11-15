class Comment
  include DataMapper::Resource
  property :id, Serial
  property :username, String, required: true
  property :comment, String, required: true
  property :created_at, DateTime, required: true

  attr_accessor :data

  # check the data is valid or not
  def check()
    result = true
    result = false if @data[:username].to_s.empty? || @data[:comment].to_s.empty?
    return result
  end

  # # get the data
  # def getInfo()
  #   puts 'a'
  #   puts @data
  #   puts 'b'
  #   return @data
  # end


end
