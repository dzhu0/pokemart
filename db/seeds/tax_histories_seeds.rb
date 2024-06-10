require 'csv'

csv_text = File.read(Rails.root.join('db', 'csv', 'tax_rates.csv'))
csv = CSV.parse(csv_text, headers: true)

puts 'Adding Tax Histories.'

csv.each do |row|
  province = Province.find_or_create_by(name: row['province'])

  TaxHistory.create!(
    province: province,
    pst: row['pst'],
    gst: row['gst'],
    hst: row['hst']
  )
end

puts 'Tax Histories added.'
