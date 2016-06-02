# Note:
# File "data/all_collections_file" must be updated before running this program
# Copy json of all collections by going to: https://[mystore].myshopify.com/admin/collections.json?limit=190
# Then paste into file "data/all_collections_file"
# The limit can be changed at will, max=250

require 'json'
require 'pry'

@outcomes = {
  collection_titles: [],
}

DIVIDER = '------------------------------------------'

def main
  puts "starting at #{Time.now}"

  collections = get_collections()

  collections.each do |collection|
    @collection_id = collection['id']
    @collection_title = collection['title']
    @outcomes[:collection_titles].push @collection_title
  end

  puts "finished at #{Time.now}"

  File.open(wfilename, 'w') do |file|
    file.write @outcomes.to_json
  end

  @outcomes.each_pair do |k,v|
    puts "#{k}: #{v.size}"
  end
end

def wfilename
  "all_collection_titles_#{Time.now.strftime("%Y-%m-%d_%k%M%S")}.json"
end

def rfilename
  "data/all_collections_file.json"
end

def get_collections()
  file = File.read(rfilename)
  JSON.parse(file)['collections']
end

main
