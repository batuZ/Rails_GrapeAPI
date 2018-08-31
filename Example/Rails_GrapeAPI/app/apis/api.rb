require 'AM/car.rb'
require 'AM/ship.rb'
require 'BM/ship.rb'
class API < Grape::API
  format :json
  mount AM::Car
  mount AM::Ship
  mount BM::Ship
  # try:
  # http://localhost:3000/api/car_hello
  # http://localhost:3000/api/ship_hello
  # http://localhost:3000/api/plain_hello
=begin

要求：
  1、模块必须在同名子文件夹中
  2、不同模块间类可以同名但函数名不能相同

=end


################ 健壮参数 ########################

  params do

    # requires 必须传入的参数
    requires :year, type: Integer

    # optioal 可选传入的参数
    optional :month, type: String, default: 'none'

  end

  # 测试传参
  get 'testpams' do
    data = {
      'year' => params['year'],
      'month' => params['month']
    }
  end
  # 传参错时
  # {
  #   "error": "year is missing"
  # }
  # or 传参正确
  # {
  #   "year": 2222,
  #   "month": "none"
  # }



end

