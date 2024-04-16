require 'csv'
require 'open-uri'

GOOGLE_DOC_ID = "1eSlPqBKoNSWBbcld_m9kYByBtSpVA10VTQXFEOGP9Oc"
PATH = "../LanguegeSelector/LanguegeSelector/Localization"

puts "Downloading translations..."
url = "https://docs.google.com/spreadsheets/d/#{GOOGLE_DOC_ID}/gviz/tq?tqx=out:csv"

begin
  content = URI.open(url).read
rescue OpenURI::HTTPError => e
  puts "Invalid URL - #{e.message} - #{url}"
  puts "Have you made sure to change the visibility?"
end

file = CSV.new(content)

data = {}

file.each_with_index do |line, i|
  next if line == "" # Ignore blank lines

  if i == 0 # Getting locales from header
    line.each do |locale|
      next if locale == "" # Ignore blank cells
      data.merge!({ locale.downcase.to_sym => [] })
    end

  else # Loading data into memory
    data.keys.each_with_index do |locale, locale_index|
      data[locale] << [line[0], line[locale_index + 1]]
    end
  end
end

data.keys.each_with_index do |locale, i|
  path = "#{PATH}/#{locale}.lproj/Localizable.strings"

  puts "Setting data for #{locale} into #{path}..."
  output = ""
  data[locale].each do |item|
    output = output + "\"#{item[0]}\" = \"#{item[1]}\";\n"
  end

  File.write(path, output) # File needs to already exist
end

puts "... all done!"
