Rails.application.routes.draw do
  mount API => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'
end
