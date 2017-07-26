class Activity < ApplicationRecord

  has_many :notificatons, dependent: :destroy
end
