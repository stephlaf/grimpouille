# frozen_string_litteral: true

require 'airrecord'

class AirtableSeed < Airrecord::Table
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
end
