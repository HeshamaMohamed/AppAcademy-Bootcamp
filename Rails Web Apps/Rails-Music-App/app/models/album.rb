class Album < ApplicationRecord

    validates :title, :year, :location, :band_id, presence: true
    validates :location, inclusion: ["studio" , "live"]

    belongs_to :band
    
    has_many :tracks,
    dependent: :destroy

end
