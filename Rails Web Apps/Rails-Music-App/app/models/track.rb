class Track < ApplicationRecord

    validates :title, :ord, :album_id, presence: true
    validates :regular_or_bonus, inclusion: ["regular", "bonus"]
    validates :ord, uniqueness: { scope: :album_id }, numericality: true
    
    belongs_to :album

    has_one :note

end
