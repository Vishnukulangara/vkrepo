class User
  include Mongoid::Document
  field :username
  field :password
  field :email
  field :name 

  
end
