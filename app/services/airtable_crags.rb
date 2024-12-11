# frozen_string_litteral: true

require 'airrecord'

class AirtableCrags < Airrecord::Table
  self.base_key = 'appCoiCY9TIjMfk2I'
  self.table_name = 'tblOwEg9OEvdIkr8E'
  self.api_key = ENV.fetch('AIRTABLE_TOKEN')

  REGION = 'fldxz3XIzayuoMmFk'
  SECTOR = 'fldru68OvSkeZoXXB'
  CRAG = 'fldWMWagaHKdBaa6K'
  RAW_ROUTES = 'fldPD08benNBV9Wbz'

  DATA_FILE = 'db/scraped_data/bronze_routes/bronze_routes_data_skaha.json'

  def self.export_to_table
    routes_hash = JSON.parse(File.read(DATA_FILE))
    sector = routes_hash.keys.first

    routes_hash.values.flatten.each do |crags|
      crag_name = crags.keys.first
      raw_routes_json = crags[crag_name].to_json
      create_record(sector, crag_name, raw_routes_json)
    end
  end

  def self.create_record(sector, crag_name, raw_routes_json)
    create(
      REGION => 'Okanagan Valley',
      SECTOR => sector.capitalize,
      CRAG => crag_name,
      RAW_ROUTES => raw_routes_json
    )
  end
end
