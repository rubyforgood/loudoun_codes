password = TokenPhrase.generate

Contest.create!

Account.create(username: "admin", password: password, admin: true, contest: Contest.instance)
puts "SAVE YOUR PASSWORD AND YOUR USERNAME :"
puts "admin:#{password}"
