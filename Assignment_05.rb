=begin
Description

Assignment:

1.
sample input structure: (suppose this is the list of tasks & related time log data for an employee for a particular day from morning 9:30am to evening 6:30pm )

[{ id: <task1 id>, name: <task1_name>, time_logs: [[<start_time>, <end_time>], [<start_time>, <end_time>]], ...}, <task2>, <task3>, ...]

eg:
(sample valid input)
[
    { id: 1, name: "task1", time_logs: [[DateTime.parse("2023-01-01 9:30:00"), DateTime.parse("2023-01-01 10:30:00")],
                                        [DateTime.parse("2023-01-01 12:00:00"), DateTime.parse("2023-01-01 13:00:00")]] },
    { id: 2, name: "task2", time_logs: [[DateTime.parse("2023-01-01 10:30:00"), DateTime.parse("2023-01-01 11:30:00")],
                                        [DateTime.parse("2023-01-01 13:00:00"), DateTime.parse("2023-01-01 14:30:00")]] },
    { id: 3, name: "task3", time_logs: [[DateTime.parse("2023-01-01 11:30:00"), DateTime.parse("2023-01-01 12:00:00")],
                                        [DateTime.parse("2023-01-01 14:30:00"), DateTime.parse("2023-01-01 15:30:00")]] },
    { id: 4, name: "task4", time_logs: [[DateTime.parse("2023-01-01 15:30:00"), DateTime.parse("2023-01-01 16:30:00")]] },
    { id: 5, name: "task5", time_logs: [[DateTime.parse("2023-01-01 16:30:00"), DateTime.parse("2023-01-01 17:30:00")]] },
    { id: 6, name: "task6", time_logs: [[DateTime.parse("2023-01-01 17:30:00"), DateTime.parse("2023-01-01 18:30:00")]] },
  ]


expected output format:

  {
    categories: ["task1", "task2", "task3", "task4", "task5", "task6"],
    total_time: [<total_spent_time_in_minutes_for_task1>,  .. <total_spent_time_in_minutes_for_task6>],
    total_time: [<(total_spent_time_in_minutes_for_task_1 / (24 * 60)) * 100>, .. <(total_spent_time_in_minutes_for_task_6 / (24 * 60)) * 100>]
  }

  
1. Define required class & methods for it
2. split down the main method into multiple methods meaningfully
3. validate input & handle exception for invalid input
4. write unit test cases for this class functionalities using rspec
=end

require 'date'

class Task
  attr_accessor :id, :name, :time_logs

  def initialize(id, name, time_logs)
    @id = id
    @name = name
    @time_logs = time_logs
  end

  # This method returns the total time used for the task
  def total_time_in_minute
    time_logs.sum { |time_log| get_time_duration_in_minute(time_log[0], time_log[1]) }.round
  end

  # This method takes total time used for a task and returns the in percentage form for a day
  def occupation_percecntage_day_wise(total_time_in_minute)
    (total_time_in_minute.to_f / (24 * 60) * 100).round(2)
  end

  # This method does the validation
  def valid?
    validates_id && validates_name && validates_time_logs
  end

  private
  
  # This methods takes an time log array as argument [start_time, end_time] and retures the duration in minute
  def get_time_duration_in_minute(start_time, end_time)
    duration = DateTime.parse(end_time) - DateTime.parse(start_time)
    duration.to_f * 24 * 60
  end

  # This method validate the the id
  def validates_id
    if id.nil?
      puts "Task - validates_id failed - A Task must contain an id"
      return false
    end

    unless id.kind_of?(Integer)
      puts "Task - validates_id failed - id must be Integer"
      return false
    end

    true
  end
  
  # This method validate the the name
  def validates_name
    if name.nil?
      puts "Task - validates_name failed - A Task must contain a name"
      return false
    end

    unless name.kind_of?(String)
      puts "Task - validates_name failed - name must be String"
      return false
    end

    true
  end

  # This method validate the the time logs
  def validates_time_logs
    if time_logs.nil?
      puts "Task - validates_time_logs failed - A Task must contain time_logs"
      return false
    end

    unless time_logs.kind_of?(Array)
      puts "Task - validates_time_logs failed - time_logs must be array"
      return false
    end

    time_logs.each do |time_log|
      return false unless validates_time_log(time_log)
    end

    true
  end

  # This method validate the the time log
  def validates_time_log(time_log)
    unless time_log.kind_of?(Array)
      puts "Task - validates_time_log failed - Each time log inside time_logs must be an array"
      return false
    end

    unless time_log.length == 2
      puts "Task - validates_time_log failed - Each time log inside time_logs must be an array of size two"
      return false
    end

    unless time_log[0].kind_of?(String) || time_log[1].kind_of?(String)
      puts "Task - validates_time_log failed - Each time log inside time logs must be an array of size two of type string"
      return false
    end

    unless is_valid_date_time_format(time_log[0]) && is_valid_date_time_format(time_log[1])
      puts "Task - validates_time_log failed - Each time log inside time logs must be proper date-time format"
      return false
    end

    if DateTime.parse(time_log[0]) > DateTime.parse(time_log[1])
      puts "Task - validates_time_log failed - end time earlier than start time - for id = #{id} and name = #{name}"
      return false
    elsif DateTime.parse(time_log[0]) == DateTime.parse(time_log[1])
      puts "Task - validates_time_log failed - start time and end time can't be same - for id = #{id} and name = #{name}"
      return false
    end

    true
  end

  # This method validate the date-time format using regex
  def is_valid_date_time_format(date_time)
    !!(date_time.match(/(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2})/))
  end
end

class TaskHandler
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def add_task(task_attributes)
    begin
      self.validate_inputs(task_attributes)
      task = Task.new(task_attributes[:id], task_attributes[:name], task_attributes[:time_logs])
      if task.valid?
        @tasks << task
      else
        puts "Task with id: #{task_attributes[:id]} not added"
      end
    rescue => e
      puts "Error occured in add_task: #{e.message}"
      puts "Task with id: #{task_attributes[:id]} not added"
    end
  end

  def add_tasks(task_attr_array)
    begin
      task_attr_array.each do |task_attr|
        self.add_task(task_attr)
      end
    rescue => e
      puts "Error occured in add_tasks: #{e.message}"
    end
  end

  def process_input
    report = {
      categories: [],
      total_time_in_min: [],
      occupation_percecntage: []
    }
    
    begin
      tasks.each_with_index do |task, index|
        report[:categories] << task.name
        report[:total_time_in_min] << task.total_time_in_minute
        report[:occupation_percecntage] << task.occupation_percecntage_day_wise(report[:total_time_in_min][index])
      end
    rescue => e
      puts "Error occured in process_input: #{e.message}"
    end

    report
  end

  private

  def validate_inputs(task_attributes)
    raise "Attribute id of Task is not present" if task_attributes[:id].nil?
    raise "Attribute name of Task is not present" if task_attributes[:name].nil?
    raise "Attribute time_logs of Task is not present" if task_attributes[:time_logs].nil?
    raise "Task with id: #{task_attributes[:id]} alredy present" if self.tasks.any? { |task| task.id == task_attributes[:id] }
  end
end

task_day_one = TaskHandler.new
task_day_one.add_tasks([
  { id: 1, name: "task1", time_logs: [["2023-01-01 9:30:00", "2023-01-01 10:30:00"],
                                      ["2023-01-01 12:00:00", "2023-01-01 13:00:00"]] },
  { id: 2, name: "task2", time_logs: [["2023-01-01 10:30:00", "2023-01-01 11:30:00"],
                                      ["2023-01-01 13:00:00", "2023-01-01 14:30:00"]] },
  { id: 3, name: "task3", time_logs: [["2023-01-01 11:30:00", "2023-01-01 12:00:00"],
                                      ["2023-01-01 14:30:00", "2023-01-01 15:30:00"]] },
  { id: 4, name: "task4", time_logs: [["2023-01-01 15:30:00", "2023-01-01 16:30:00"]] },
  { id: 5, name: "task5", time_logs: [["2023-01-01 16:30:00", "2023-01-01 17:30:00"]] },
  { id: 6, name: "task6", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] },
])
task_day_one.add_task({ id: 7, name: "task7", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
task_day_one.add_task({ id: 8, name: "task8", time_logs: [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] })
task_day_one.add_task({ id: 9, name: "task9", time_logs: [["2023-01-01 18:30:00", "2023-01-01 18:30:00"]] })
task_day_one.add_task({ id: 10, name: "task10", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
task_day_one.add_task({ id: 13, name: "task13", time_logs: [["2023-01-01 17:30:00", "2023-01-01"]] })

puts "Output: #{task_day_one.process_input}"