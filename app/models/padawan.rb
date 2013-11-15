class Padawan < ActiveRecord::Base
  attr_accessible :name
  has_many :apprenticeships
  has_many :jedis, :through => :apprenticeships
end
