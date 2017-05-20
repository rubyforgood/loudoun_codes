password = TokenPhrase.generate
Administrator.create(username: "admin", password: password)
puts "SAVE YOUR PASSWORD AND YOUR USERNAME :"
puts "admin:#{password}"

Contest.create
