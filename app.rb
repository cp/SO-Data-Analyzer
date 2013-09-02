require 'csv'

query = File.read('QueryResults.csv')
data = Array.new

def predict(title, body)
  unprocessed_tags = Array.new
  processed_tags = String.new

  unprocessed_tags << common_word(body)

  unprocessed_tags.each do |tag|
    processed_tags << tagify(tag.to_s) unless tag.nil?
  end

  return processed_tags
end

def common_word(body)
  title_array = body.split(' ')
  title_array[0]
end

def tagify(string)
  '<' + string + '>' unless string.empty?
end

CSV.parse(query, headers: true, header_converters: :symbol) do |row|
  data.push({
    title: row[:title], 
    body: row[:body], 
    tags: row[:tags], 
    predicted_tags: predict(row[:title], row[:body])
  })
end

CSV.open("FinalResults.csv", "wb") do |csv|
  csv << ["Title", "Body", "Tags", "Predicted Tags"]
  data.each do |post|
   csv << [post[:title], post[:body], post[:tags], post[:predicted_tags]]
  end
end
