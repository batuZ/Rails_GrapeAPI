class BoyAPI < Grape::API
	format :json

	# http://localhost:3000/boy/helloboy
	get 'helloboy' do
		data = {
  				'time' 	=>	Time.new,
  				'ip'	=>	request.ip
  			}
  			present data
      #  as_json返回模型对象的散列表示，而to_json返回一个json对象。
	end
  	



  	################  嵌套路由  http://localhost:3000/boy/:boy_id
  	resources ':boy_id' do

  		# http://localhost:3000/boy/3
  		# => 'boy_id': '3'
  		get do
  			data = {
  				'boy_id' => params[:boy_id]
  			}
  			present data
  		end
  		
  		# http://localhost:3000/boy/43/logout
  		# => 'type' : 'post'
  		post 'logout' do
  			data = {
  				'type' => 'post',
  				'boy_id' => params[:boy_id]
  			}
  			present data
  		end
  		
  	end






end