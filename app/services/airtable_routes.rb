# frozen_string_litteral: true

require 'airrecord'

class AirtableRoutes < Airrecord::Table
  self.base_key = 'appCoiCY9TIjMfk2I'
  self.table_name = 'tblzRcP97hKpRTEVG'
  self.api_key = ENV.fetch('AIRTABLE_TOKEN')

  # Routes table
  CRAG_NAME = 'fldgDpD9BxjyAkBBF'
  CRAG_ID = 'fldGUaY46tlOchQNn'
  ROUTE_NAME = 'flddGjo667NXE1gzl'
  URL = 'flddGJvbVAUTE1tB6'
  BOLTS = 'fld4Lqy87tc3FKC8K'
  GRADE = 'fld7iqI6ZkVsYCekw'
  STARS = 'fld1cmJYsAkZr7zH1'
  HEIGHT = 'fldsaRjWqBexWce8R'
  STYLE = 'fldPc9LhdkJPmFGqT'

  def self.create_record(route_attributes)
    create(
      CRAG_NAME => route_attributes[:crag_name],
      CRAG_ID => [route_attributes[:id]],
      ROUTE_NAME => route_attributes[:name],
      URL => route_attributes[:url],
      BOLTS => route_attributes[:bolts],
      GRADE => route_attributes[:grade],
      STARS => route_attributes[:stars],
      HEIGHT => route_attributes[:height],
      STYLE => route_attributes[:style]
    )
  end

  def self.write_to_airtable(crags)
    crags.each do |crag|
      crag[:route_infos].each do |route_hash|
        route_hash[:id] = crag[:id]
        route_hash[:crag_name] = crag[:crag]
        create_record(route_hash)
      end
    end
    nil
  end

  def self.extract_routes_data(raw_route_data)
    route_hash = JSON.parse(raw_route_data)

    name = route_hash['name']
    grade = route_hash['gradeAtom']['grade']
    stars = route_hash['stars']&.to_i
    bolts = route_hash['bolts']&.to_i
    style = route_hash['styleStub']
    height = route_hash['displayHeight']&.first.to_i
    { name: name, grade: grade, stars: stars, style: style, height: height, bolts: bolts }
  end

  def self.extract_data(raw_data)
    raw_data.map do |data_hash|
      name = data_hash.keys.first
      infos = data_hash[name]
      route_data_hash = extract_routes_data(infos['data'])
      route_data_hash[:url] = "https://www.thecrag.com#{infos['link']}"
      route_data_hash
    end
  end

  def self.fetch_raw_routes
    all_crags = AirtableCrags.all
    all_route_data = all_crags.map do |crag|
      route_data = {}
      route_data[:id] = crag.id
      route_data[:region] = crag.fields['Region']
      route_data[:sector] = crag.fields['Sector']
      route_data[:crag] = crag.fields['Crag']
      route_data[:route_infos] = extract_data(JSON.parse(crag.fields['Raw Routes']))
      route_data
    end
    all_route_data
  end
end
