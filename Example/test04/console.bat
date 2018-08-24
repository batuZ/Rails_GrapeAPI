@echo off
rem 创建API工程
rem rails new test04 --api

rem 创建对象
rem rails g model Position x:float y:float z:float
rem rails g model Sound url
rem rails g model User name 

rem 建立对象关系
rem rails g migration add_userid_to_sound user:belongs_to:index
rem rails g migration add_soundid_to_position sound:belongs_to:index

rem 增加功能：用户听力范围，默认20
rem rails g migration add_range_to_user range:float:default:20.0


rem rails db:migrate
rem rails db:rollback
rem rails db:setup
rem rails active_storage:install