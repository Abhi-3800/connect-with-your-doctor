class Hospital < ApplicationRecord
    has_many :hospital_updates, dependent: :destroy
end
