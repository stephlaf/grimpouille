# # frozen_string_litteral: true

# unless Rails.env.production?
#   Attempt.destroy_all
#   Climb.destroy_all
#   User.destroy_all
#   Pitch.destroy_all
#   Route.destroy_all
#   Crag.destroy_all
#   Sector.destroy_all
#   Region.destroy_all
# end

# ines = User.create!(first_name: 'Ines', last_name: 'Alvergne', email: 'i@i.i', password: 111111)
# steph = User.create!(first_name: 'Stephane', last_name: 'Lafontaine', email: 's@s.s', password: 111111)

# catalunya = Region.create!(name: 'Catalunya')
# siurana = Sector.create!(name: 'Siurana', region: catalunya)
# herbolari = Crag.create!(name: "L'Herbolari", sector: siurana)

# brain_storming = Route.create!(
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

# pp AirtableSeed.all
