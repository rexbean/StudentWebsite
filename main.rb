require './test'

params = Hash.new
params[:firstname] = 'aaa'
params[:lastname] = 'bbb'
params[:address] = 'ccc'
# params[:birthday] = 'dddd'
params[:student_id] = 'eeee'
student = Test.new
student.data = params

Test.create(student.getInfo())
# Test.create(firstname: 'a', lastname:'b', address:'c', student_id:'e')
# student.save
