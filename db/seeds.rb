30.times do
  title = Faker::Hipster.sentence(word_count: 2)
  et = ['Cinema', 'Theatre', 'Concerts', 'Exhibitions', 'Other'].sample
  pl = Faker::Address.full_address
  nop = rand(1..100)
  desc = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)
  #random_date = Faker::Time.between_dates(from: today, to: end_date, format: :default)
  # Вернет строку, так как Faker::Time.between_dates возвращает строку, а не объект Time
  random_date = Faker::Time.between_dates(from: Date.today , to: Date.today + 1.month, period: :all) #=> "2014-09-19 07:03:30 -0700"
  ed = random_date.strftime('%Y-%m-%d %H:%M:%S')
  Event.create title: title, event_type: et, place: pl, num_of_people: nop,
               description: desc, event_date: ed, user_id: 1
end

puts 'Seeds have been planted!'
