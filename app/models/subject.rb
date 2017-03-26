class Subject < ApplicationRecord

  # 1:1 association
  # has_one :page

  # 1:M association
  has_many :pages

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where.not(visible: true) }
  scope :sorted, -> { order(position: :ASC) }
  scope :newest_first, -> { order(created_at: :DESC) }
  scope :search, -> (query) { where( arel_table[:name].matches("%#{query.downcase}%") ) }

  # This checks to see if there is a string when the form is submitted: rejecting if there is no string.
  validates_presence_of :name
  validates_length_of :name, maximum: 255

end
