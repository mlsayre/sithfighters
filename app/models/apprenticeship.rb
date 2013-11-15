class Apprenticeship < ActiveRecord::Base
  attr_accessible :jedi_id, :padawan_id
  belongs_to :jedi
  belongs_to :padawan
end
