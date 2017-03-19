class Page < ApplicationRecord

  # 1:1 and 1:m association
  # use << to append to parent table
  has_many :pages
  belongs_to :subject
  has_and_belongs_to_many :admin_users

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where.not(visible: true) }
  scope :sorted, -> { order(position: :ASC) }
  scope :newest_first, -> { order(created_at: :DESC) }
  scope :search, -> (query) { where( arel_table[:name].matches("%#{query.downcase}%") ) }

end
