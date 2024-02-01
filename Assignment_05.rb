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

class TaskHandler
  def initialize(input)
    @input = input
  end

  def validate
    unless @input.kind_of?(Array)
      puts "Input must be Array"
      return false
    end

    @input.each_with_index do |task, index|
      task[:time_logs].each do |time_log|
        if DateTime.parse(time_log[0]) > DateTime.parse(time_log[1])
          puts "Time logs validation failed for id = #{task[:id]} and name = #{task[:name]}"
          return false
        end
      end
    end

    return true;
  end

  # This is the main entry method of the program. It takes the input and returns the output.
  def get_report_output()
    unless validate
      return "Validation Failed"
    end

    res = {
      categories: [],
      total_time_in_min: [],
      total_time_in_min_percent: []
    }

    @input.each_with_index do |task, index|
      res[:categories] << task[:name]
      res[:total_time_in_min] << calculate_total_time_in_min(task[:time_logs])
      res[:total_time_in_min_percent] << calculate_total_time_in_min_percent(res[:total_time_in_min][index])
    end

    return res
  end

  # This method takes all the time log for a task and returns the total time used for that task
  def calculate_total_time_in_min(time_logs)
    time_logs.sum { |time_log| get_time_duration_in_min(time_log) }.round()
  end

  # This methods takes an time log array as argument [start_time, end_time] and retures the duration in minute
  def get_time_duration_in_min(time_log)
    duration = DateTime.parse(time_log[1]) - DateTime.parse(time_log[0])
    duration = duration.to_f * 24 * 60
    return duration.to_f
  end

  # This method takes total time used for a task and returns the in percentage form for a day
  def calculate_total_time_in_min_percent(total_time_in_min)
    (total_time_in_min.to_f / (24 * 60) * 100).round(2)
  end
end

task_one = TaskHandler.new([
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

puts "Output: #{task_one.get_report_output}"