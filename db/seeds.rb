Contest.create! unless Contest.instance

unless Account.where(admin: true).exists?
  password = TokenPhrase.generate

  Account.create(username: "admin", password: password, admin: true, contest: Contest.instance)
else
  password = Account.find_by(username: "admin", admin: true).password
end

unless Rails.env.test?
  puts "SAVE YOUR PASSWORD AND YOUR USERNAME :"
  puts "admin:#{password}"
end
