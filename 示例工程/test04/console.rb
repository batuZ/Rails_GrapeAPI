puts '>>>>> RUN'
p @u = User.first

p @s =Sound.create(url: 'http', user_id: @u.id)

pp _.errors.messages
puts '>>>>> END'