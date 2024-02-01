=begin
1. Write a class and define a class method which will return the object count of that class.
2. Write a class (with constructor) to define instance methods for getting area & perimeter of a rectangle.
3 Write an example of how you can use super method with and without arguments.
4. Write a program to define two modules and both having a method with same name but with different functionality and then define a method in a class and use those module methods inside that.
5. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as a class method of that class.
6. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as an instance method of that class.
=end

# Question 4
# This is ModuleOne having a static function greet
module ModuleOne
  def self.greet(name)
    puts "Hello #{name}"
  end
end

# This is ModuleTwo having a static function greet
module ModuleTwo
  def self.greet(name)
    puts "Hi #{name}"
  end
end

# This a class, using the ModuleOne and ModuleTwo having two methods say_hello and say_hi
class Question4
  include ModuleOne, ModuleTwo

  def say_hello(name)
    ModuleOne.greet(name)
  end

  def say_hi(name)
    ModuleTwo::greet(name)
  end
end

q4 = Question4.new
q4.say_hello("AC")
q4.say_hi("AC")
print "\n\n"

# This is a HelloWorld module having a function print_hello_world
module HelloWorld
  def print_hello_world
    puts "Hello World"
  end
end

# Question 5
# This is a class using the HelloWorld module with the extend keyword
class Question5
  extend HelloWorld
end

Question5.print_hello_world()
print "\n\n"

# Question 6
# This is a class using the HelloWorld module with the include keyword
class Question6
  include HelloWorld
end

Question6.new.print_hello_world()