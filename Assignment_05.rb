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

  def initialize(id="deafult", name="deafult", time_logs=[])
    @id = id
    @name = name
    @time_logs = time_logs
  end

  # This method returns the total time used for the task
  def total_time_in_minute
    time_logs.sum { |time_log| get_time_duration_in_minute(time_log[0], time_log[1]) }.round()
  end

  # This method takes total time used for a task and returns the in percentage form for a day
  def occupation_percecntage_day_wise(total_time_in_minute)
    (total_time_in_minute.to_f / (24 * 60) * 100).round(2)
  end

  # This method validate the the time logs
  def validate_time_logs
    time_logs.each do |time_log|
      if DateTime.parse(time_log[0]) > DateTime.parse(time_log[1])
        puts "Time logs validation failed for id = #{id} and name = #{name}"
        return false
      end
    end
    true
  end

  private

  # This methods takes an time log array as argument [start_time, end_time] and retures the duration in minute
  def get_time_duration_in_minute(start_time, end_time)
    duration = DateTime.parse(end_time) - DateTime.parse(start_time)
    duration.to_f * 24 * 60
  end
end

class TaskHandler
  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def add_task(task)
  end

  def add_all_task(tasks)
    tasks.each do |a_task|
      some_task = Task.new(a_task[:id], a_task[:name], a_task[:time_logs])
      if some_task.validate_time_logs
        @tasks << some_task
      else
        puts "Task with id: #{a_task[:id]} not added"
      end
    end
  end

  def process_input
    report = {
      categories: [],
      total_time_in_min: [],
      occupation_percecntage: []
    }

    tasks.each_with_index do |task, index|
      report[:categories] << task.name
      report[:total_time_in_min] << task.total_time_in_minute
      report[:occupation_percecntage] << task.occupation_percecntage_day_wise(report[:total_time_in_min][index])
    end
    
    report
  end
end

task_day_one = TaskHandler.new
task_day_one.add_all_task([
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

puts "Output: #{task_day_one.process_input}"