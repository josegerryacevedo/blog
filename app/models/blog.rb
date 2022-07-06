class Blog < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :user

end
