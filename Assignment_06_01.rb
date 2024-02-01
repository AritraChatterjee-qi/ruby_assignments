=begin
1. Write a class and define a class method which will return the object count of that class.
2. Write a class (with constructor) to define instance methods for getting area & perimeter of a rectangle.
3 Write an example of how you can use super method with and without arguments.
4. Write a program to define two modules and both having a method with same name but with different functionality and then define a method in a class and use those module methods inside that.
5. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as a class method of that class.
6. Write a program to define a method inside a module and then use the module in a class such a way that the method can be accessible as an instance method of that class.
=end

# Question 1
# This class have a class variable that stores the number of objects created and a method to display it
class CountObjClass
  @@count = 0
  
  def initialize
    @@count += 1
  end
  
  def show_count
    puts "No. of obj = #{@@count}"
  end
end

c1 = CountObjClass.new
c1.show_count
c2 = CountObjClass.new
c2.show_count
c3 = CountObjClass.new
c3.show_count
print "\n\n"

# Question 2
# This is a class Rectangle having two instance variable length and breadth and two functions area and perimeter to calculate it
class Rectangle
  def initialize(length=0, breadth=0)
    @length = length
    @breadth = breadth
  end

  # This functions calculates the area of the reactangle and returns it
  def area
    begin
      raise ArgumentError, "Argument must be a positive integer" if @length.class!= Integer || @breadth.class!= Integer
      @length * @breadth
    rescue TypeError => e
      return "Error: #{e}"
    rescue => e
      return "Error: Something went wrong, #{e}"
    end
  end

  # This functions calculates the perimeter of the reactangle and returns it
  def perimeter
    begin
      2 * (@length + @breadth)
    rescue TypeError => e
      return "Error: #{e}"
    rescue => e
      return "Error: Something went wrong, #{e}"
    end
  end
end

rec1 = Rectangle.new(10, 10)
puts "Area of rec1 = #{rec1.area}"
puts "Perimeter of rec1 = #{rec1.perimeter}"
rec2 = Rectangle.new()
puts "Area of rec2 = #{rec2.area}"
puts "Perimeter of rec2 = #{rec2.perimeter}"
rec3 = Rectangle.new("10", "10")
puts "Area of rec2 = #{rec3.area}"
puts "Perimeter of rec2 = #{rec3.perimeter}"
print "\n\n"

# Question 3
# This is a class Person having name and age as instance variable and a instance method desribe to print them
class Person
  def initialize(name="No Name", age=-1)
    @name = name
    @age = age
  end

  def describe
    puts "Name: #{@name}, Age: #{@age}"
  end
end

# This is a class Engineer, inheriting the class Person and overridding the describe method
class Engineer < Person
  def initialize(name="No Name", age=-1, company="No Company")
    super(name, age)
    @company = company
  end

  def describe
    super
    puts "Company: #{@company}"
  end
end

e1 = Engineer.new("AC", 22, "QI")
e1.describe()
e2 = Engineer.new()
e2.describe()