user = User.find_or_initialize_by(full_name: 'temo', email: 'tardzenadze@vaba.co')
user.assign_attributes(password: '123456', password_confirmation: '123456')
user.save