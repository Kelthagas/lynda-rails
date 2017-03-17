class Page < ApplicationRecord

  # 1:1 and 1:m association
  # use << to append to parent table
  belongs_to :subject
  has_and_belongs_to_many :admin_users

end
