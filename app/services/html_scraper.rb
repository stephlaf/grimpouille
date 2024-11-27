# frozen_string_litteral: true

require 'nokogiri'
require 'json'


def parse_to_nokogiri_doc(html)
  Nokogiri::HTML.parse(html)
end

def write_to_file(region_name, routes_data)
  routes_filepath = "db/scraped_data/bronze_routes/bronze_routes_data_#{region_name}.json"

  File.open(routes_filepath, "wb") do |file|
    file.write(JSON.pretty_generate(routes_data))
  end
end

def scrape(doc)
  selector = 'div.route'
  routes_data = []

  sector_name = doc.search('h1 > span.heading__t').text.strip

  doc.search(selector).each do |element|
    begin
      name = element.search('div.title > span.name').text.gsub('★', '').strip
      data = element.attribute('data-route-tick').value
      link = element.search('div.title > span.name > a').attribute('href').value
      routes_data << { name => { link: link, data: data } }
    rescue NoMethodError
    end
  end

  { sector_name => routes_data }
end

folderpath = 'db/scraped_data/skaha_data/skaha_html_files/*.html'
all_routes_by_sectors = []

Dir::glob(folderpath) do |html_file|
  doc = parse_to_nokogiri_doc(File.open(html_file).read)
  all_routes_by_sectors << scrape(doc)
end

skaha_routes_by_sectors = { 'skaha' => all_routes_by_sectors }
write_to_file('skaha', skaha_routes_by_sectors)
