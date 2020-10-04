require 'csv'

HEADERS = %w[Name Sex].freeze

NAME = '1 NAME'.freeze
SEX = '1 SEX'.freeze

def parse_row_value(line, deliminator)
  line.split(deliminator).last.strip
end

def add_to_csv?(line, new_row)
  return false if new_row.empty?
  return true if line.include?('0 TRLR')

  line.include?('0 @I') && line.include?('INDI')
end

CSV.open('./output.csv', 'w+') do |csv|
  csv << HEADERS

  new_row = []

  File.readlines('./file.ged').each do |line|
    if add_to_csv?(line, new_row)
      csv << new_row
      new_row = []
    end

    new_row[0] = parse_row_value(line, NAME) if line.include?(NAME)
    new_row[1] = parse_row_value(line, SEX) if line.include?(SEX)
  end
end
