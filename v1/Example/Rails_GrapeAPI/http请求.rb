require 'net/https'
require 'uri'
require 'json'
require 'pp'

base_path = 'http://localhost:3000/api'
def getRequiest
	params = {}
	params["username"] = 'yangjun'
	uri = URI.parse("#{base_path}/test")
	# 发送
	res = Net::HTTP.post_form(uri, params)
	resbody = JSON.parse(res.body)
	pp resbody
end

def postRequiest
	params = {}
	params["username"] = 'yangjun'
	uri = URI.parse("#{base_path}/test")

	req = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
	req.body = params.to_json

	res = Net::HTTP.new(uri.host, uri.port).start{|http|
	    http.request(req)
	}

	resbody = JSON.parse(res.body)
	puts resbody
end