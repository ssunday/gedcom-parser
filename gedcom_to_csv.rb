require 'csv'
require_relative './lib/constants'

HEADERS = %w[Name Sex BirthDate BirthPlace].freeze

def parse_row_value(line, deliminator)
  line
    .split(deliminator)
    .last
    .strip
    .gsub('/', '')
end

def in_sub_data?(line)
  line.split('2 ').first
end

def add_to_csv?(line, new_row)
  return false if new_row.empty?
  return true if line.include?('0 TRLR')
  return false unless line.include?(' INDI')

  line.include?('0 @I')
end

def parse_ged_line(new_row, line, in_birth_data)
  new_row[0] = parse_row_value(line, NAME) if line.include?(NAME)
  new_row[1] = parse_row_value(line, SEX) if line.include?(SEX)
  new_row[2] = parse_row_value(line, SUB_DATE) if in_birth_data && line.include?(SUB_DATE)
  new_row[3] = parse_row_value(line, SUB_PLACE) if in_birth_data && line.include?(SUB_PLACE)
end

CSV.open('./output.csv', 'w+') do |csv|
  csv << HEADERS

  new_row = []
  in_birth_data = false

  File.readlines('./file.ged').each do |line|
    if add_to_csv?(line, new_row)
      csv << new_row
      new_row = []
      in_birth_data = false
    end

    if line.include?(BIRTH_START)
      in_birth_data = true
    elsif in_birth_data && !in_sub_data?(line)
      in_birth_data = false
    end

    parse_ged_line(new_row, line, in_birth_data)
  end
end
