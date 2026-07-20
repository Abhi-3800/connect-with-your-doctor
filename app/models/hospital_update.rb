class HospitalUpdate < ApplicationRecord
    validates :reason, presence: true
    belongs_to :hospital
end
