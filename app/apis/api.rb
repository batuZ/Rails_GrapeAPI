class API < Grape::API

  format :json

  mount AM::Car
  mount AM::Ship
  mount BM::Ship
  # try:
  # http://localhost:3000/api/car_hello
  # http://localhost:3000/api/ship_hello
  # http://localhost:3000/api/plain_hello
end

=begin

要求：
	1、模块必须在同名子文件夹中
	2、不同模块间类可以同名但函数名不能相同

=end