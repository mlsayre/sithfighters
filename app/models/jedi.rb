class Jedi < ActiveRecord::Base
  attr_accessible :name
  has_many :apprenticeships
  has_many :padawans, :through => :apprenticeships
end
