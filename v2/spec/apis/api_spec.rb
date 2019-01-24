require 'rails_helper'

# 创建 user model
# rails g model User userName password_digest userBio
# rails g model Sound uuid url user_id:integer

# 在迁移文件中指定用户名为唯一
# class CreateUsers < ActiveRecord::Migration[5.2]
#   def change
#     create_table :users do |t|
#       t.string :userName
#       t.string :password_digest
#       t.string :userBio

#       t.timestamps
#       t.index :userName, unique: true
#     end
#   end
# end

# 设置 model: user.rb
# class User < ApplicationRecord
# 	# 指定唯一字段，且不为空
# 	validates :UserName, presence: true, uniqueness: true
# 	# 密码验证
# 	has_secure_password
# end
