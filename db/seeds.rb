# # frozen_string_litteral: true

unless Rails.env.production?
  Attempt.destroy_all
  Climb.destroy_all
  User.destroy_all
  Pitch.destroy_all
  ClimbingRoute.destroy_all
  Crag.destroy_all
  Sector.destroy_all
  Region.destroy_all
  Province.destroy_all
  Country.destroy_all
end

ines = User.create!(first_name: 'Ines', last_name: 'Alvergne', email: 'i@i.i', password: 111111, admin: true, developer: true)
steph = User.create!(first_name: 'Stephane', last_name: 'Lafontaine', email: 's@s.s', password: 111111, admin: true, developer: true))

# catalunya = Region.create!(name: 'Catalunya')
# siurana = Sector.create!(name: 'Siurana', region: catalunya)
# herbolari = Crag.create!(name: "L'Herbolari", sector: siurana)

# brain_storming = ClimbingRoute.create!(
#   name: 'Brain Storming',
#   grade: '6b',
#   style: 1,
#   crag: herbolari
# )

# brain_storming_pitch = Pitch.create!(
#   length: 22,
#   position: 1,
#   grade: '6b',
#   bolts: 8,
#   angle: 2,
#   route: brain_storming
# )

# brain_storming_ines = Climb.create!(climber: ines, route: brain_storming, status: 4) #, attempts: 2)
# brain_storming_steph = Climb.create!(climber: steph, route: brain_storming, status: 3) #, attempts: 2)

# attempt_date_day1 = DateTime.new(2024, 03, 26)
# attempt_date_day2 = DateTime.new(2024, 03, 27)

# brain_storming_ines_attempt1 = Attempt.create!(date: attempt_date_day1, notes: 'Pioupioupiou', status: 4, climb: brain_storming_ines)
# brain_storming_ines_attempt2 = Attempt.create!(date: attempt_date_day2, notes: 'Siempre pioupioupiou', status: 4, climb: brain_storming_ines)

# brain_storming_steph_attempt1 = Attempt.create!(date: attempt_date_day1, notes: 'Wouaahhhh', status: 4, climb: brain_storming_steph)
# brain_storming_steph_attempt2 = Attempt.create!(date: attempt_date_day2, notes: 'Wouhou!', status: 3, climb: brain_storming_steph)

canada = Country.create!(name: 'Canada', grading_system: 'YDS')
puts 'Creating Canada country'

bc = Province.create!(name: 'British Columbia', country: canada)
puts 'Creating British Columbia province'

okanagan_valley = Region.create!(name: 'Okanagan Valley', province: bc)
puts 'Creating okanagan_valley region'

skaha = Sector.create!(name: 'Skaha', region: okanagan_valley)
puts 'Creating skaha sector'

uniqs_crag_records = AirtableSeed.all.uniq { |record| record['Crag'] }

uniqs_crag_records.each do |record|
  puts "Creating #{record['Crag']} crag"
  Crag.create!(name: record['Crag'], sector: skaha)
end

# pp Crag.all

AirtableSeed.all.each do |route_data|
  ActiveRecord::Base.transaction do
    puts "Creating #{route_data['Route name']} route"
    climbing_route = ClimbingRoute.create!(
      name: route_data['Route name'],
      grade: route_data['Grade'],
      style: AirtableSeed.format_style(route_data['Style']),
      crag: Crag.find_by_name(route_data['Crag']),
      stars: route_data['Stars'],
      url: route_data['URL'],
      height: route_data['Height']
      )

    pitch = Pitch.new(
      position: 1,
      length: climbing_route.height,
      pitch_grade: climbing_route.grade,
      angle: 90,
      bolts: route_data['Bolts']
    )

    pitch.climbing_route = climbing_route
    pitch.save!
  end
end
