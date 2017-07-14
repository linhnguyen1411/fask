class Company < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  belongs_to :work_space
end
