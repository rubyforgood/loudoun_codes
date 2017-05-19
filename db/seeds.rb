password = TokenPhrase.generate
Admin.create(username: "admin", password: password)
puts "SAVE YOUR PASSWORD AND YOUR USERNAME :"
puts "admin:#{password}"

