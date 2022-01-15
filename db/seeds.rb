user = User.find_or_initialize_by(full_name: 'temo', email: 'tardzenadze@vaba.co')
user.assign_attributes(password: '123456', password_confirmation: '123456')
user.save



country = Country.find_or_create_by(name: 'Georgia', code: 'GE', active: true)

city = City.find_or_create_by(name: 'Tbilisi', code: '001', active: true, country_id: country.id)

district = District.find_or_create_by(name: 'Vake', code: '001', active: true, city_id: city.id)

BusinessUnit.find_or_create_by(
  name: 'TTH', code: 'TTH', active: true,
  country_id: country.id, city_id: city.id, district_id: district.id
)