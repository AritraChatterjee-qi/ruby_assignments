=begin
1. Write a class and define a class method which will return the object count of that class.
2. Write a class (with constructor) to define instance methods for getting area & perimeter of a rectangle.
3 Write an example of how you can use super method with and without arguments.
4. Write a program to define two modules and both having a method with same name but with different functionality and then define a method in a class and use those module methods inside that.
5. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as a class method of that class.
6. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as an instance method of that class.
=end

#  Q4
module Module1
  def self.greet(name)
    puts "Hello #{name}"
  end
end

module Module2
  def self.greet(name)
    puts "Hi #{name}"
  end
end

class Question4
  include Module1, Module2


  def say_hello(name)
    Module1.greet(name)
  end
  def say_hi(name)
    Module2::greet(name)
  end
end

q4 = Question4.new
q4.say_hello("AC")
q4.say_hi("AC")
print "\n\n\n"

# Q5
module Ques5
  def hello_world()
    puts "Hello World - Q5"
  end
end

class Question5
  extend Ques5
end

Question5.hello_world()
print "\n\n\n"

# Q6
module Ques6
  def hello_world()
    puts "Hello World - Q6"
  end
end

class Question6
  include Ques6
end

# q6 = Question6.new
# q6.hello_world()
Question6.new.hello_world()
print "\n\n\n"