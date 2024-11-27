# frozen_string_litteral: true

require 'open-uri'
require 'nokogiri'
require 'json'


def fetch_nokogiri_doc(url)
  pp html = URI.open(url).read
  Nokogiri::HTML.parse(html)
end

def write_to_file(area_name, routes_data)
  routes_filepath = "db/scraped_data/skaha_bronze_routes_data_#{area_name}.json"

  File.open(routes_filepath, "wb") do |file|
    file.write(JSON.pretty_generate(routes_data))
  end
end

def scrape(link, selector)
  pp html_doc = fetch_nokogiri_doc(link)

  routes_data = html_doc.search(selector).map do |element|
    pp element
    # begin
      pp name = element.search('div.title > span.name').text.strip
      pp data = element.attribute('data-route-tick').value
      pp link = element.search('div.title > span.name > a').attribute('href').value
    pp { name => { link: link, data: data } }
    # rescue NoMethodError
    #   p 'error'
    # end
  end

  routes_data
end

base_url = 'https://www.thecrag.com'
filepath = 'db/scraped_data/skaha_bronze.json'
selector = 'div.route'
sector_urls = JSON.parse(File.read(filepath))

sector_urls.first(1).each_with_object({}) do |link_hash, result_hash|
  area_name = link_hash.keys.first
  route_data = scrape(base_url + link_hash.values.first, selector)
  result_hash[area_name] = route_data

  write_to_file(area_name, result_hash)
end
