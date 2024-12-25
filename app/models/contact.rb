class Contact < ApplicationRecord
  belongs_to :applicant

  enum :contact_type, residential: 0, mobile: 1, commercial: 2, whatsapp: 3, email: 4

  validates :value, presence: true
end
