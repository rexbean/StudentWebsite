class Student
  include DataMapper::Resource
  property :id, Serial
  property :firstname, String, required: true
  property :lastname, String, required: true
  property :birthday, Date
  property :address, String
  property :student_id, String

  attr_accessor :data

  def check()
    result = true
    result = false if @data[:firstname].to_s.empty? || @data[:lastname].to_s.empty? || @data[:birthday] !~ /^\d\d\d\d-\d\d?\d\d?$/
    return result
  end

  def getInfo()
    puts 'a'
    puts @data
    puts 'b'
    return @data
  end

end
