class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits
  has_many :admin_users, :through => :section_edits

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where.not(visible: true) }
  scope :sorted, -> { order(position: :ASC) }
  scope :newest_first, -> { order(created_at: :DESC) }
  scope :search, -> (query) { where( arel_table[:name].matches("%#{query.downcase}%") ) }

end
